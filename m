Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07066C0015E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 15:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGYPSs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 11:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGYPSr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 11:18:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9A0E5A
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690298326; x=1721834326;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=POUUGIDQmYbr0UXB5WFRozlPHZCldIrBkPYcdmbjzvY=;
  b=NGvP96PXKoE024IAq5mn8AJBOqfPwYgRc7YBUjusEQXiWbZYbR7uXzp2
   PT6aQD4sP31/rr9dDfph38PLYUhBHdxuVHIRdl4FQHCmew5UszNdztj0y
   xVEbGetDeqyvr5x+HFxN33xMDNkJ/IaiOUX+9EVB9PQ5MjndfNaBix3QK
   0RBsMlTHDoRE2jp25P08hVzcAhbm6Q83uajYJekJDJkabyBa6kT/a5YIY
   R4ifweduWSaqadpMvvgjpnOSmcJPSRdWimkmqKngmqsVEC/XitY6wp0lt
   EMj+sJZnpVrk9Ct/SZexa88rhvRA/Qmd7ioqNYAHiSNnNknLUBfHpCy+N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434010305"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="434010305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:18:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="850067436"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="850067436"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 25 Jul 2023 08:18:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 08:18:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 08:18:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 08:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGnKZFH5p5oWiyOSEVgc8Nf+ZDkCeFL8XMwWQY4K5xg6PH5pfdZ+xOsF4ysFSFciMqEP3uavtOTO/wfis/lZ3Ivm6+rxtWFMosbLoQmLnDRlReTXxNZFmOPF8Fp6pB8IMT7EU7N76JFDFbuewfhPDLpO5ymC9SX0lbCB48FMUd10pgbMK6lAmoHYeLjOnt5EAyIDoJ2blgQUBEzpvS9zzlSJGw4qqUUWHEGfQc8G3AN8/wRKDasDHe26S9E1mg69oBaZ9/Kd6tSSdRa4Nx3LvAcM4KoyEjPK8if0uq4Bjl/ZKUT85XYKE85mAz7ftQGVTJkXQjtA5eSFCnKCJShnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy434QVLOXp4KOcBRSFw4RxHYN5HW+Zh424pKaVBd3o=;
 b=STGrcraldEkPIY2GWVRVC+f559SbWMI4LbZusvY2B7KpTYrp/b7dSR+l/OVOkzD5i4Rh4hACFGHF48a+qlcoEN4gW8FwFnpsrwYe7nrKv03Vd+rHqNHwK2iOd6/du35a+tlyfr6mgF82MLiv7Vr1c7QCk8eVo1mJOyEH9U+zcmSAaZOhoY58cKdAti0sDlUE+T7FXzOUwlVPdkSnHErKx1d8W88pADOGEGAC2MQrLDPa+ESM0M3mecccgULI0Qd5hzVp8mZfZg9Oa3vExDDnbEkbEDGUiwxMUssXchFLLUykXV5J4tz8f4UKA5JZbYViz9oG11FwRogp26Dse+k2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 15:18:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:18:22 +0000
Date:   Tue, 25 Jul 2023 08:18:08 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Message-ID: <64bfe7b090843_12757b2945b@iweiny-mobl.notmuch>
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
 <20230511175609.2091136-1-fan.ni@samsung.com>
 <20230724171857.GA329893@bgt-140510-bm03>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724171857.GA329893@bgt-140510-bm03>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 816d6118-b4cc-4d15-9a50-08db8d22622c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMj1i1isj6gjWyGDGtPRFBAdHylNzAGwu+CKedx4PnOsac2qy52jnJZ1AK8bVpTucdWXZxOjDTgRQmYkDa8AQhRbCk8l8IU/jCXm1kulDY8rFQLM337wNbr5e7QcEfULBxFz0E/pawR70tK3At09YcqpWEt9/1JKkuEuK06gnloxJ8ORAMbvKdrjE6eJ9mTzpfnW1zyB5eLHH7wAfvTQtjCYK/Z+SWX8QmnvwbC0vA8ZBxoIpRXYc4gn8S45AB7g6lK1vs+E4SOo+2AEWD47YvuaNg4piV0liXF23CYmWSQ/kdl0bhSpjSXdNoOmYn7MCwK2uMqZoRbeFcPMDZ4QQrKzyE3RAqBqBkUv3TAVNOx5xl4HkYdJVWwPMY4daWNNQJ5mEi9HUbLDT6WrND0VyiN5sk4pso2CT0vrgghaXYD/9XPcF8ArdKXNDha7Mg9onRltLchrlzjdLLYKQmHclFFDtoz0lrpvD4HCXS8voWT/aYbnS0kb5dMjBQPOeK4JR5SeWTxsYMZhQ1y4dO9Joiu+EKJSNwXeXPlqjrjN0gHTc1ijPkjTp/pymwbnm4zGw6BcG8W01Cj0RDwzCzwIcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199021)(186003)(26005)(6506007)(2906002)(86362001)(82960400001)(54906003)(7416002)(8676002)(8936002)(4326008)(478600001)(110136005)(966005)(6666004)(9686003)(6512007)(6486002)(38100700002)(5660300002)(41300700001)(66556008)(316002)(66476007)(44832011)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2R3UG8vd3dFc2NzSko3Y1llN3ByU0h2TW1iRXg3RGg2S3d2bFVxM0pBc0t0?=
 =?utf-8?B?WHZNMWxiMEQzVmVvOERKRUxMMXZ0c0E5dWNvSDY1OVBEY1NYdlJNa20xSStR?=
 =?utf-8?B?Y0laRVlMUVFza1pFYmsrVlU5ckZKY0hXb1ZqMTUxSS9zN0RDbjdoRFdrQXQx?=
 =?utf-8?B?azB5YUhRR1dWaW5YbkJJa2xGY05ETjZ6NnRCOXhyWEJZc2JRTFNzbnFGSm4y?=
 =?utf-8?B?ZzB6SlgzOVlaN0R0V0hzakJXbE95cXZzUU5pazdsV1VyZ016MFgwVFNHRlVy?=
 =?utf-8?B?Qks4eHdEYTlPZUVBVnhiNWtKR2tWdkxEVFplV1Z5Q1NQVXg5eE9rRTVYYWNF?=
 =?utf-8?B?ak5uczFCMkY1NWkxblRhNy9ORG9sMWZBWi9oU1dPQzlpUFpSUGh3TXFkT2pm?=
 =?utf-8?B?VXZEWSsrVmFkd2NNMVRSYlBHZ0oxOUFjd3BROGhNM0ZuK1hidFpuMkxnUFlE?=
 =?utf-8?B?LzZ5UWV6SkpPdy9aYmZ0Z2o2RzNhUkR3S3R3blF3WCsrY1ZYOUhQSHdrUkFr?=
 =?utf-8?B?NjFTNjFwZE1QUWx4Tk1UOTZvTGNLUnVnbFNWNkJDUlpHcVdsRVFHRkY0aXFY?=
 =?utf-8?B?R2JVbitRSDFoelNvaXFpeDVCU01Oc0FnU0FsckFBNGdWVzB6NGFwek9kcG5l?=
 =?utf-8?B?b0g2Vkd5a0lXZDQ0M3J4TnVHOWRJbXQvUEtZNExKT0dCbUxGNjA1SDBuMHlS?=
 =?utf-8?B?VGt3Z2d4Q216T2l6L3gwcDExcDRrR1RuNUJxZk1YbFJPSmhhNGdqOVBLbkdJ?=
 =?utf-8?B?OWY1Z0t4NkFFakFmTnlSTVVBVnR2Q1l1Uk55K3lJQUZQUGhURUVaVjl1Q2po?=
 =?utf-8?B?KzVBQkZkOUdDMnZwaVZIZ3NKaXRxR3IwVE1LRGxPT0RmaTNJRURBaklRSVc2?=
 =?utf-8?B?T1NEQ0UwRml1ZjQ4OWRBZnBVczlENHljdHhXU1ptSUhJYmtheTNIZXdOL3Nl?=
 =?utf-8?B?c0JWTXllTzV2UVd6ZFhhVUlDeHl1cWJjc0xIdlVVdHhnZE9EUzA0RXFLSzda?=
 =?utf-8?B?ZEZOaHdZSkVXUzJ6Nk5QNTBjdjJTdUdsN25TaXNZMmFzS2s1YWFLSFF6WlN3?=
 =?utf-8?B?OW9XM1pwRGo3YWFrVmg3emR3UUZlNFg5QUQyTkl2MW9ycHVUOUp3ck9VZ2Ix?=
 =?utf-8?B?Zm9sdytUOE55c3k3QTR1WjJ5cWFnTTJoRGtDLy8zMVdudzF3TjdWNlQxQXBW?=
 =?utf-8?B?WWNMU0lCQm1YWDRERVBkTE0zcHM1WkZXMFp4N1JObjI4QjFCQUUzM0pKbkpB?=
 =?utf-8?B?RlhkMGlSWXZwelJVbnUrdlFZd3Rod09DQm9ZRzE0UUc3VDJWMDhobmJkbVlL?=
 =?utf-8?B?eXgwMkQ2NklLU3JaQi9RWXJlQytQTEcwZlZ1Ym9PQnc1Q3FSSTQ0U0wySXh5?=
 =?utf-8?B?VWo2V2JURi9veExYb2h3RUp5MU5QNXpVVzA3QURrQVZod0U1ZWZRWU9QT1FP?=
 =?utf-8?B?NlZBcVNLaEdLUkJuekNSUXRUMVJLc1k3bkowVWRjMHVraDZSTDI0M3AwM1c1?=
 =?utf-8?B?RzZJdGNXWG5DQjNHMjlLT0pKRUdXRE1nRVl1TkZ0Szc1d3lRNFJrTTZ0K3VG?=
 =?utf-8?B?QlhvenN0d2RqWC9SM0x6VzE5VXNlUWp5d1NSZlA1NHlTdHR0ZGg5bVJrbFFy?=
 =?utf-8?B?U2s0c2U4cm9nUmNiRnRyZXNBMC9EWk82YkEwTkxuck82bi9VUmJvdXNCQzRk?=
 =?utf-8?B?YmRlQXczWXpDeGdqL1FtN2VIUW9ESjFCenc1SlQ2NEhoTUI2bllxemtUcmth?=
 =?utf-8?B?ODJpS0VRSVdCbkQ4eGU2MjNWR2ZQd1FoZmZQaUduNlFlM3VVZGc0TmxPUVVG?=
 =?utf-8?B?dXY2a1BDRlF4UitYTCtLcDIrdVRzWFZKcWNFS1RyWDJhQVNtMGRqNHZ1OG95?=
 =?utf-8?B?YWtpZTF3eFI4ak5pMThUcE9UYnEwaFBlb3RpdmVGY1R6dGdXaW0xci9FNFVU?=
 =?utf-8?B?NVVuVm9abFR2Q3Y5MFgxUjc3UENUeE0wazcvanl0NlA0MXZjQ3ZFV0Y5VU5n?=
 =?utf-8?B?R3NBZzlBSHF2MGV0b21JN0lFaTNiVHQ4YXB2cE9pRlM3UU9zeUtRMEZpQlRw?=
 =?utf-8?B?aDdZeTVyeXVaWHVIaFNmV0NhN2w3YkoxM3ZsNm9pS05KNEVsN2syK3hCYXhN?=
 =?utf-8?Q?ocsshGx1mNE5Y/LrzybWqroM0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 816d6118-b4cc-4d15-9a50-08db8d22622c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:18:22.1393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJ/vFjrKKsTbkYE9Q8JLHHj/dWzSqOHfs8iTx7MtDvlyp2LgHh/GT1KiizshfHBwPCNJElBZ1UCBojGazi2VPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> On Thu, May 11, 2023 at 05:56:40PM +0000, Fan Ni wrote:
> 
> FYI.
> 
> I have updated the patch series and sent out again.
> 
> I suggested anyone who are interested in DCD and using this patch series to
> use the new series. Quite a few things has been fixed.
> 
> https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#t
> 
> Also, if you want to use the code repo directly, you can try
> 
> https://github.com/moking/qemu-dcd-preview-latest/tree/dcd-dev

Thanks for the branch!

I took a quick look and I don't see a resolution to the problem I
mentioned with non DCD devices being supported.[1]

[1] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/

Did you fix this in a different way?  If I don't add DC to my mem devices they
don't get probed properly.  I'm still looking into this with your new branch,
but I don't think DC commands should be in the CEL if the device does not
support it.

Also I get a build warning on this branch I had to fix[3] as my build is
treating warnings as errors.[2]

I don't think this fix is technically necessary as 'list' should never be NULL
that I can see.  But might be nice to check or just use my fix.

I'll try and get to a review once I get the DCD stuff out on the list again.

Ira


[2]
../hw/mem/cxl_type3.c: In function ‘qmp_cxl_process_dynamic_capacity_event.constprop’:
../hw/mem/cxl_type3.c:2063:28: error: ‘rid’ may be used uninitialized [-Werror=maybe-uninitialized]
 2063 |     dCap.updated_region_id = rid;
      |     ~~~~~~~~~~~~~~~~~~~~~~~^~~~~
../hw/mem/cxl_type3.c:1987:13: note: ‘rid’ was declared here
 1987 |     uint8_t rid;
      |             ^~~
cc1: all warnings being treated as errors

[3]

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e67328780407..d25e6064f6c9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1984,7 +1984,7 @@ static void qmp_cxl_process_dynamic_capacity_event(const char *path,
     CXLDCExtentRecordList *list = records;
     CXLDCExtent_raw *extents;
     uint64_t dpa, len;
-    uint8_t rid;
+    uint8_t rid = 0;
     int i;
 
     if (!obj) {
