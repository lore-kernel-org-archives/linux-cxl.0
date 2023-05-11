Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5908C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 19:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbjEKTsf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 15:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjEKTsV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 15:48:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D112983E6
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 12:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXOcwxlutrS9IFVRp2pq4FOmxCcAPfOxigQWb3XryZNiekQ3nOXQGLtXr9U/6ICcozJDl5BuTJeW8mzchJDpGmjzoHJ7v9ekP/e2BS/IDsuBK8RUpV3Z2gCisPJCXMBRzb9AHBDUleHu22W0wVI7vlvz59ZmDtCIPZk8AouzJBV0htoOLaTsNZKxuAZhGAAxW0QOnqyTDqQX8Rt1LuPsWwqUiQivWoFH0vRmUyVNIQ+ixXlaGZb3eY+TmiDr/866U2iov8wBDKjv8qoC3Z4n86k8DxnYfBFevKqykKn8TQGH63gdInsD3ptB1ryGC5njeIbnqYDrH6Q0wweBLymASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdWW/rbFu8MTcBJ9NXFgsd2wsqQrd6hGhoI/BjmM500=;
 b=TYfu6dol0h9KsPj2ZFEv3NgIrE639KnaMGnasaauxmj1/FFYEFxAV/Ll3/FJbvD2au6Wt0Hd9fM2UCO7L4eCx3tBWHGnNpa+jTfDD+hYYmBB7YL0c/DsAS39NvN2I2LIHdtZ0+rw09BR7mYLGtuUISqdmWHcqCmiDqRwrucRs55i7b4hV+v4ALblL2KyyoGzE9cukFKX/lWRnYzZsADLKrhL1K9geg4nbZ89NUuBsSiZ96hgGO5utxYV+G/chllRB5zcHZxlHZdIIvBPQuRZggUVjDBLbdRryN9NP6f8+aGUy8AhkdsSlERE8C4FvFeI0ltvCwZwgNQAVx7BeMF0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdWW/rbFu8MTcBJ9NXFgsd2wsqQrd6hGhoI/BjmM500=;
 b=DLNy3hVyA8Mp9ks1QnIKdGUBlFXQmie5bQ9iTDZCtGQU6TDHDqo+glclvj1efjB5UQB3A9uzi19e+SezoIl/63uzG8TnOEZdZN53pk8zSlebhDmWk23d4V8PYjDmvAKMRhrx+mLSOWbWIIajX5xQi6LvPNQnd6KB8YUMgvpz4zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 19:47:03 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::59d3:73ae:a342:baad]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::59d3:73ae:a342:baad%5]) with mapi id 15.20.6363.026; Thu, 11 May 2023
 19:47:03 +0000
Message-ID: <6f1e7b65-fb95-ffc6-636c-032766f7c270@amd.com>
Date:   Thu, 11 May 2023 14:47:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [ndctl RFC] cxl/region: Add support to create dc region for
 dynamic capacity device
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
References: <CGME20230511180852uscas1p12736929a3b7da261a94fe661f151cc66@uscas1p1.samsung.com>
 <20230511180757.2091508-1-fan.ni@samsung.com>
From:   Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230511180757.2091508-1-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::23) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|BY5PR12MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: c269eb0d-087a-4702-597a-08db52587e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKNVCAUaXuI0R7mmMNwmXpyT1Y9TInN2aqo7389vIHjks2+4nEgvJF7NuvWpMl/NuMQbU4dWDCcPfhe8PvIca4gK7DeX2oHsNNgZbLCp3U7i5G/WG5//6Te5xVJJAYNcedA/bZ0HTYnLfiZV/mB4znESBZSzIO7Ex50FUBVFH8BiHhV3PDhzYuCGKwnzMTflyIpAY9grS7IynbtA+xopG/BZ/1QrexB06uYIK2by1Hc/0JA/iI8srMCHQH5G93lPEkESlzRudsgO0nE5Eu0F6RV/koU1lkyq6zwzVkr63lszEb/GVZ2o2WIhLZb0JmuUmvSFCHvPjMrTpNsd15Ugkv23NFOceaRK/YuVWl84Xyulr0g5OPpzLO4zbhf9RCU3lPrWF5uEQABo28US/9YMC+6XQCvpK3vaWcLSGxwoB5vVQ1t5FO2vFXbDs3NF5wRVazhvluwTMjnKe6ooOIas6Y1S+gEZT/k7NkxrmBOCpo79ujnmQ74WJ4XyHFVB3caC0dUfI8Jw6TAbXt8HCJTgJieB8qKTtQkUHpEKauHAiYneACkcBEVBNnLvzsDin5Dg2Ox/wPmUUeqb4kI8OivdwV1eBqFCDqqKW5YnFi+hh5EMxMpCSL++NqzCMFpHjPghRK7z6mWzSywaF8FVL5uwkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(2616005)(31686004)(186003)(66476007)(66946007)(316002)(66556008)(8676002)(8936002)(5660300002)(4326008)(41300700001)(6506007)(6512007)(2906002)(26005)(86362001)(54906003)(478600001)(110136005)(36756003)(38100700002)(31696002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTV3YXRKN0QzUGRCQ2tySVlVQUhVN0xHWnZrN3R4Vm9PRDlJSktHRUVKSjk1?=
 =?utf-8?B?UWFhRk1xKzNCaldPZFhRZmxUWFJRRjNOZHVteGs2VmpRZUlWTi84OTBqQ0FJ?=
 =?utf-8?B?U01LTGFhV1JtVEtSMHhFRDV6VVNjdmRldkpDM1cyNUZkU3padGczYWNST1lj?=
 =?utf-8?B?d0tzZEp3MTZGcW5XWlBMSS93TFAwSkF6K1c3cGFiUTk1Q0RWcU1DRU9jb3Q2?=
 =?utf-8?B?UktTdkx5WnIzeVJMcDhzRlVMdGRBSGYrZ2kxdUpBSmJwRW5pVFhnUHQvK0Zj?=
 =?utf-8?B?YWMzNGx3SFVoeXp0dktDN2JXd2xUcVE2Ylc5Zi9JeUJhZlFrbUg5YUg4MTg2?=
 =?utf-8?B?VVNFdDNvSGVMOGgrc1A3azdNNjMyVFIwQk5lSlJVakFyR2ZKaTVkRUNucCtL?=
 =?utf-8?B?ck41WHZMdFMrOTU4eVQ3TjRxTjhmdkN1SmpNdi9HeFhLWnU0YUJaSm9CYW01?=
 =?utf-8?B?T1ZhcGorM0l6ZW1YcExSQ3pkcWU1K2hPTFZjU2JtV0hpOGY2WHFQSzlNWm1C?=
 =?utf-8?B?Q2VPb1krQllPRWNXRFRXQkpCMkVzTlZXd25BdGgzNnhSbVN5SFh5Mys5Vjdv?=
 =?utf-8?B?QlpzNXVZYWN2bDNWdERaK2JkWGdhZW5lckp0bExKSCsxTEl2bjduNzI3MlBN?=
 =?utf-8?B?WmpNdTVFNXZERVZhakRGZDc1SUNob1h2NVpKZ0NlNk1QZ0RHMXpHTk52bG5K?=
 =?utf-8?B?c2VpTlJkWWJSQm5XZm5JY0NhME0xVVlkK3FyMHVKK0QwOW5kU0lmUnlYMjBF?=
 =?utf-8?B?cVpYdC9jQXpWR0VVT2crRS9qRmJaRlp2d0F5eVpGc2JuZ2tlWGs1ZUdhSnZF?=
 =?utf-8?B?RUliZ0tZUnBkR2xxUXlIWmQwSGJ2d0VsQ2ExNXZITDhxbVUwRlkxQ29OOEx5?=
 =?utf-8?B?REVhZ2NiUVJYQnZEYW5hK1J1OTdlRVdXcVNBVlJIWGRhSTZENkhocUE3NFgy?=
 =?utf-8?B?dTlhL1ljMWh4V0NmMHAwSlRrQmtnWmRsMHJVczM4U1FNSHNSRUxyaDFKZWQ2?=
 =?utf-8?B?Znh2Q2prU24zZ0pJeER3dnhFU3QvZjdrUkJNMnJzVEg5U1J0bjJUUXVNYlBM?=
 =?utf-8?B?VzUxdk9JTkcwemFYbVcwaFk5ckM5TVBDcTEzMnZoNy80WEY3Tjk0cDZ2c1hU?=
 =?utf-8?B?c2F1OXRiVkdnUjdKSXE1b2dnQ2tKS21nK3F5Z3lxNUphQjJ5c0pBRGFJdlRJ?=
 =?utf-8?B?dmx0MEhzcENHR0hxMmNuUkp1SE9tQThneXlEdVA2WXZSQ2I2UHQvb2xLeXc5?=
 =?utf-8?B?aENQRzZTOFNtZ3ZoWnY2M2Z0ZElkL21uQjdZcmd3T2NyVHlUN0lhdlc0OXFN?=
 =?utf-8?B?U1h6OUt0cEdqS1NaZml4NjU0Q2FYZ0d2NWQ5TzJYUmN2cXoxbVpNYU5VSzFU?=
 =?utf-8?B?TGtRZHlhTU16eElLTnJ3TWxrNnhKRUZzNzljTnAvb00zTUkxY0NqSStmNkZR?=
 =?utf-8?B?cjZiWUtOa044cWpicDNvZ3pnWTY3T1NZSTZKQTlJcFU4bDBidGlHVnhxcHdv?=
 =?utf-8?B?M1p0WS9KbmphaDFhS3FlOUtMZWtrMGljMmZDQ0RhZ0hlTkRlU0Q3UHNjcUE3?=
 =?utf-8?B?NWpwbkJxZVZNLzNQdjhtbnRGUXNoc2E4UkZua2E2eFkwMG5LRlIyZVZ3SS9W?=
 =?utf-8?B?UnZuNlp3c0RuU2h6NVUwL3ZhcXpiWndwcHpVeWhmc0liU0pXM3Q1bWM2Y2cx?=
 =?utf-8?B?TDFiN01nbWtUOHZFYWd4bENUeXg3UWo1QUpJdnhUc2d6bjJuTkdodlprL25I?=
 =?utf-8?B?VnZrYWtCOUs5bU16T3Z2Mjd6ZVJpYjg3OEppY2MrbVJ3MkU3Ulg2SlR6Tk5i?=
 =?utf-8?B?OVN4d01LOXBRYzBNVVR6ejhqanRiWmRWNm41YXJZc3BWdU9lS0txQU9mU1k2?=
 =?utf-8?B?MW9KZlc1QjY1dENYQXRpY3E3RzJ0a25rWmh3M0dRcjN5enNkMXZjcVJkMDU4?=
 =?utf-8?B?SmIvSkhVVG93ZWtBelBnV1FMcGZNalgwWW1qVWhyK3FpL0dWaFBpYkhJMktv?=
 =?utf-8?B?cjlqaXBFNjBWOEhleHJpTXZzSEVYUFRGakhnd1R6YXVFMW5yR3BBNlNrMFJR?=
 =?utf-8?B?TG9tTTkwcjM0ck9HVFhLVDdYYitLNDJrWDlPZzVVYmhkZHRKVy9LU3krZkM2?=
 =?utf-8?Q?qd6br00Cu71CfUq9w83KSZ0Qo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c269eb0d-087a-4702-597a-08db52587e13
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 19:47:03.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S1oz1NhET7Lg6apYxPm0CfU9LjMOGrnLRmQtP7psn6Xj82nNQjScU51Qi0aUylBV2hZOFSVNK1MSOz63VnixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Fan,

I actually have a patch series that does this and adds cxl list support for DC regions that I've been 
sitting on. I was going to wait to send it out until the kernel DCD support was a bit more mature, 
but since you sent this out I thought I may as well put the list support out there so we don't
duplicate work. I've copy/pasted the patch below, feel free to add it to your patch/make modifications.

Subject: [PATCH] Add cxl list support for dynamic capacity regions

Add support for printing dynamic capacity regions to cxl list. Region
support is broken into two pieces: support for the cxl region, and
support for device level dc regions. The device level dc regions are
printed under the memdev in the list output since they are a memdev
attribute in sysfs. There are a maximum of eight of these regions,
only the regions that are present in sysfs are printed.

Example output:
(assume device has regions 0 and 1 populated, and region0 was created
 using create-region -t dc)
[
    {
	"memdevs":[
	  {
	    "memdev":"mem0"
	    "pmem_size":536870912,
	    "ram_size":1,
	    "serial":0,
	    "host":"0000:0d:00.0",
	    "dc_regions":[
	      {
		"region_nr":0,
		"size":268435456,
		"base":268435456,
		"blk_size":2097152
	      },
	      {
		"region_nr":1,
		"size":268435456,
		"base":536870912,
		"blk_size":2097152
	      }
	    ]
	  }
	]
    },
    {
	"regions":[
	  {
	    "region":"region0",
	    "resource":19595788288,
	    "size":536870912,
	    "type":"dc",
	    "interleave_ways":1,
	    "interleave_granularity":256,
	    "decode_state":"commit"
	  }
	]
    }
]

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 cxl/json.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.c   | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  4 ++++
 cxl/lib/private.h  |  8 +++++++
 cxl/libcxl.h       |  7 ++++++
 5 files changed, 139 insertions(+)

diff --git a/cxl/json.c b/cxl/json.c
index 9a4b5c7..df155f8 100644
--- a/cxl/json.c
+++ b/cxl/json.c
@@ -480,6 +480,62 @@ err_jobj:
 	return NULL;
 }
 
+static void util_cxl_memdev_dc_regions_to_json(struct json_object *jdev, struct cxl_memdev *memdev,
+			       unsigned long flags)
+{
+	struct json_object *jdc_array, *jdc_region, *jobj;
+	u64 val;
+
+	jdc_array = json_object_new_array();
+	if (!jdc_array)
+		return;
+
+	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
+		jdc_region = json_object_new_object();
+		if (!jdc_region)
+			continue;
+
+		/*
+		 * Skip the region if the size is invalid, the rest is probably
+		 * also invalid. If size is 0, the region is most likely unset.
+		 */
+		val = cxl_memdev_get_dc_region_size(memdev, i);
+		if (val == ULLONG_MAX || val == 0) {
+			json_object_put(jdc_region);
+			continue;
+		}
+
+		jobj = json_object_new_int(i);
+		if (jobj)
+			json_object_object_add(jdc_region, "region_nr", jobj);
+
+		jobj = util_json_object_size(val, flags);
+		if (jobj) {
+			json_object_object_add(jdc_region, "size", jobj);
+		}
+
+		val = cxl_memdev_get_dc_region_base(memdev, i);
+		if (val < ULLONG_MAX) {
+			jobj = util_json_object_hex(val, flags);
+			if (jobj)
+				json_object_object_add(jdc_region, "base", jobj);
+		}
+
+		val = cxl_memdev_get_dc_region_blk_size(memdev, i);
+		if (val < ULLONG_MAX) {
+			jobj = util_json_object_size(val, flags);
+			if (jobj) {
+				json_object_object_add(jdc_region, "blk_size", jobj);
+			}
+		}
+
+
+		json_object_array_add(jdc_array, jdc_region);
+	}
+
+	json_object_object_add(jdev, "dc_regions", jdc_array);
+}
+
 struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 		unsigned long flags)
 {
@@ -552,6 +608,10 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
 			json_object_object_add(jdev, "partition_info", jobj);
 	}
 
+	size = cxl_memdev_get_dc_size(memdev);
+	if (size)
+		util_cxl_memdev_dc_regions_to_json(jdev, memdev, flags);
+
 	json_object_set_userdata(jdev, memdev, NULL);
 	return jdev;
 }
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index ecdc242..0dcc79e 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1211,6 +1211,37 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 		goto err_read;
 	memdev->ram_size = strtoull(buf, NULL, 0);
 
+	sprintf(path, "%s/dc/size", cxlmem_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		memdev->dc_size = 0;
+	else
+		memdev->dc_size = strtoull(buf, NULL, 0);
+
+	for (unsigned int i = 0; i < CXL_MAX_DC_REGION; i++) {
+		/*
+		 * if the first read fails, assume the region doesn't exist
+		 * and set the region to invalid values.
+		 */
+		sprintf(path, "%s/dc/base_region%d", cxlmem_base, i);
+		if (sysfs_read_attr(ctx, path, buf) < 0) {
+			memdev->dc_regions[i].base = ULLONG_MAX;
+			memdev->dc_regions[i].size = 0;
+			memdev->dc_regions[i].blk_size = 0;
+			continue;
+		}
+		memdev->dc_regions[i].base = strtoull(buf, NULL, 0);
+
+		sprintf(path, "%s/dc/size_region%d", cxlmem_base, i);
+		if (sysfs_read_attr(ctx, path, buf) < 0)
+			goto err_read;
+		memdev->dc_regions[i].size = strtoull(buf, NULL, 0);
+
+		sprintf(path,"%s/dc/blk_sz_region%d", cxlmem_base, i);
+		if (sysfs_read_attr(ctx, path, buf) < 0)
+			goto err_read;
+		memdev->dc_regions[i].blk_size = strtoull(buf, NULL, 0);
+	}
+
 	sprintf(path, "%s/payload_max", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		goto err_read;
@@ -1369,6 +1400,35 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev)
 	return memdev->ram_size;
 }
 
+CXL_EXPORT unsigned long long cxl_memdev_get_dc_size(struct cxl_memdev *memdev)
+{
+	return memdev->dc_size;
+}
+
+CXL_EXPORT unsigned long long cxl_memdev_get_dc_region_base(struct cxl_memdev *memdev,
+							    unsigned int region_nr)
+{
+	if (region_nr < CXL_MAX_DC_REGION)
+		return memdev->dc_regions[region_nr].base;
+	return ULLONG_MAX;
+}
+
+CXL_EXPORT unsigned long long cxl_memdev_get_dc_region_size(struct cxl_memdev *memdev,
+							    unsigned int region_nr)
+{
+	if (region_nr < CXL_MAX_DC_REGION)
+		return memdev->dc_regions[region_nr].size;
+	return ULLONG_MAX;
+}
+
+CXL_EXPORT unsigned long long cxl_memdev_get_dc_region_blk_size(struct cxl_memdev *memdev,
+							    unsigned int region_nr)
+{
+	if (region_nr < CXL_MAX_DC_REGION)
+		return memdev->dc_regions[region_nr].blk_size;
+	return ULLONG_MAX;
+}
+
 CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)
 {
 	return memdev->firmware_version;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 1434da6..e711273 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -254,4 +254,8 @@ global:
 LIBCXL_6 {
 global:
 	cxl_decoder_create_dc_region;
+	cxl_memdev_get_dc_size;
+	cxl_memdev_get_dc_region_base;
+	cxl_memdev_get_dc_region_size;
+	cxl_memdev_get_dc_region_blk_size;
 } LIBCXL_5;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index d49b560..968afaf 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -19,6 +19,12 @@ struct cxl_pmem {
 	char *dev_path;
 };
 
+struct cxl_dc_region {
+	u64 base;
+	u64 size;
+	u64 blk_size;
+};
+
 struct cxl_endpoint;
 struct cxl_memdev {
 	int id, major, minor;
@@ -32,12 +38,14 @@ struct cxl_memdev {
 	struct list_node list;
 	unsigned long long pmem_size;
 	unsigned long long ram_size;
+	unsigned long long dc_size;
 	int payload_max;
 	size_t lsa_size;
 	struct kmod_module *module;
 	struct cxl_pmem *pmem;
 	unsigned long long serial;
 	struct cxl_endpoint *endpoint;
+	struct cxl_dc_region dc_regions[CXL_MAX_DC_REGION];
 };
 
 struct cxl_dport {
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 1a54eee..c548abe 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -18,6 +18,8 @@ typedef unsigned char uuid_t[16];
 extern "C" {
 #endif
 
+#define CXL_MAX_DC_REGION 8
+
 struct cxl_ctx;
 struct cxl_ctx *cxl_ref(struct cxl_ctx *ctx);
 void cxl_unref(struct cxl_ctx *ctx);
@@ -47,6 +49,11 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_dc_size(struct cxl_memdev *memdev);
+unsigned long long cxl_memdev_get_dc_region_size(struct cxl_memdev *memdev, unsigned int region_nr);
+unsigned long long cxl_memdev_get_dc_region_base(struct cxl_memdev *memdev, unsigned int region_nr);
+unsigned long long cxl_memdev_get_dc_region_blk_size(struct cxl_memdev *memdev,
+						     unsigned int region_nr);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
 
 /* ABI spelling mistakes are forever */
-- 
2.34.1
