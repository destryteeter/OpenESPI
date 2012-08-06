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

package org.energyos.espi.thirdparty.domain;

import java.util.List;
import org.energyos.espi.thirdparty.domain.ThirdParty;
import org.energyos.espi.thirdparty.domain.ThirdPartyDataOnDemand;
import org.energyos.espi.thirdparty.domain.ThirdPartyIntegrationTest;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect ThirdPartyIntegrationTest_Roo_IntegrationTest {
    
    declare @type: ThirdPartyIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: ThirdPartyIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext*.xml");
    
    declare @type: ThirdPartyIntegrationTest: @Transactional;
    
    @Autowired
    private ThirdPartyDataOnDemand ThirdPartyIntegrationTest.dod;
    
    @Test
    public void ThirdPartyIntegrationTest.testCountThirdPartys() {
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", dod.getRandomThirdParty());
        long count = ThirdParty.countThirdPartys();
        Assert.assertTrue("Counter for 'ThirdParty' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void ThirdPartyIntegrationTest.testFindThirdParty() {
        ThirdParty obj = dod.getRandomThirdParty();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to provide an identifier", id);
        obj = ThirdParty.findThirdParty(id);
        Assert.assertNotNull("Find method for 'ThirdParty' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'ThirdParty' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void ThirdPartyIntegrationTest.testFindAllThirdPartys() {
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", dod.getRandomThirdParty());
        long count = ThirdParty.countThirdPartys();
        Assert.assertTrue("Too expensive to perform a find all test for 'ThirdParty', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<ThirdParty> result = ThirdParty.findAllThirdPartys();
        Assert.assertNotNull("Find all method for 'ThirdParty' illegally returned null", result);
        Assert.assertTrue("Find all method for 'ThirdParty' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void ThirdPartyIntegrationTest.testFindThirdPartyEntries() {
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", dod.getRandomThirdParty());
        long count = ThirdParty.countThirdPartys();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<ThirdParty> result = ThirdParty.findThirdPartyEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'ThirdParty' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'ThirdParty' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void ThirdPartyIntegrationTest.testFlush() {
        ThirdParty obj = dod.getRandomThirdParty();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to provide an identifier", id);
        obj = ThirdParty.findThirdParty(id);
        Assert.assertNotNull("Find method for 'ThirdParty' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyThirdParty(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'ThirdParty' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void ThirdPartyIntegrationTest.testMergeUpdate() {
        ThirdParty obj = dod.getRandomThirdParty();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to provide an identifier", id);
        obj = ThirdParty.findThirdParty(id);
        boolean modified =  dod.modifyThirdParty(obj);
        Integer currentVersion = obj.getVersion();
        ThirdParty merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'ThirdParty' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void ThirdPartyIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", dod.getRandomThirdParty());
        ThirdParty obj = dod.getNewTransientThirdParty(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'ThirdParty' identifier to be null", obj.getId());
        obj.persist();
        obj.flush();
        Assert.assertNotNull("Expected 'ThirdParty' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void ThirdPartyIntegrationTest.testRemove() {
        ThirdParty obj = dod.getRandomThirdParty();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'ThirdParty' failed to provide an identifier", id);
        obj = ThirdParty.findThirdParty(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'ThirdParty' with identifier '" + id + "'", ThirdParty.findThirdParty(id));
    }
    
}