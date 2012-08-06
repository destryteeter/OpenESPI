/*******************************************************************************
 * Copyright (c) 2011, 2012 EnergyOS.Org
 *
 * Licensed by EnergyOS.Org under one or more contributor license agreements.
 * See the NOTICE file distributed with this work for additional information
 * regarding copyright ownership.  The EnergyOS.org licenses this file
 * to you under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License.  You may obtain a copy
 * of the License at:
 *  
 *   http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing,
 *  software distributed under the License is distributed on an
 *  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *  KIND, either express or implied.  See the License for the
 *  specific language governing permissions and limitations
 *  under the License.
 *  
 ******************************************************************************
*/

// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.energyos.espi.thirdparty.web;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.energyos.espi.thirdparty.common.IntervalBlock;
import org.energyos.espi.thirdparty.common.MeterReading;
import org.energyos.espi.thirdparty.common.UsagePoint;
import org.energyos.espi.thirdparty.web.MeterReadingController;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect MeterReadingController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String MeterReadingController.create(@Valid MeterReading meterReading, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, meterReading);
            return "meterreadings/create";
        }
        uiModel.asMap().clear();
        meterReading.persist();
        return "redirect:/meterreadings/" + encodeUrlPathSegment(meterReading.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String MeterReadingController.createForm(Model uiModel) {
        populateEditForm(uiModel, new MeterReading());
        return "meterreadings/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String MeterReadingController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("meterreading", MeterReading.findMeterReading(id));
        uiModel.addAttribute("itemId", id);
        return "meterreadings/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String MeterReadingController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("meterreadings", MeterReading.findMeterReadingEntries(firstResult, sizeNo));
            float nrOfPages = (float) MeterReading.countMeterReadings() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("meterreadings", MeterReading.findAllMeterReadings());
        }
        return "meterreadings/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String MeterReadingController.update(@Valid MeterReading meterReading, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, meterReading);
            return "meterreadings/update";
        }
        uiModel.asMap().clear();
        meterReading.merge();
        return "redirect:/meterreadings/" + encodeUrlPathSegment(meterReading.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String MeterReadingController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, MeterReading.findMeterReading(id));
        return "meterreadings/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String MeterReadingController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        MeterReading meterReading = MeterReading.findMeterReading(id);
        meterReading.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/meterreadings";
    }
    
    void MeterReadingController.populateEditForm(Model uiModel, MeterReading meterReading) {
        uiModel.addAttribute("meterReading", meterReading);
        uiModel.addAttribute("intervalblocks", IntervalBlock.findAllIntervalBlocks());
        uiModel.addAttribute("usagepoints", UsagePoint.findAllUsagePoints());
    }
    
    String MeterReadingController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}