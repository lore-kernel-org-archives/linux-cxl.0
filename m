Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE144C7EE23
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 03:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCAD2T (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 22:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAD2S (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 22:28:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09843305E1
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 19:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677641294; x=1709177294;
  h=date:from:to:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=d7QGVu9Tclb+DXBrYTp8+Jhu7oCZMOQxjDScMUaUhEI=;
  b=QGlcQ8dayTVjJDDdCJ1pEW4Rh/+c6IIIjv1dTXpsT2EhlMLgSXUbWXi9
   OrGQXRFHhEb3Y130rYaeGXfB0AJmDwsTJasrztG2X3KbdASh1QRfO/3in
   Wg0hRDAJJ5niOesTqeiIzkaiF5Txr4bb2J5JAXATR+N6iMvo3ta5SXB7k
   gohIhFDCjubwsOAK0a3B4fy8HIWKX4NCu5jcp1I372B1781H+HkSbsdSl
   IK4siYHQcMetBs5XwIsxOjX9ELUIsib2e79HNd1gXJFD6ggpExFLUhnE2
   Gfa2opZfHSKOzk0gidxT1SiJrP8m5ZDkn74gqsLkJqN+NCN1rYGGiFTsj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="334346928"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="334346928"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 19:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704676106"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704676106"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 28 Feb 2023 19:28:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 28 Feb 2023 19:28:13 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Feb 2023 19:28:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 28 Feb 2023 19:28:13 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 28 Feb 2023 19:28:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHxDFtCvRA0hUmI/aDzMW4vLW0x/HK1cODkPfKFHjOVFtxZF8Dcf94xvTAiXoXsxqbwondHlxheZKEF7LGVcJ3gYBPmiTCpCUaHsIRYHQvCoWdfcRgmO5/6AA1FGLLtg0deTwNyL7SuN4T+97OoscVYg5YteX+8fb3Wl3jevprA8TbWURa0lY45D1cKxpVUMaqkmJEqj18ZS5wqH9pWL7XA7bNn6j4Ourm/LEyG+k19YK2Ch7tuVPYRdjqDmmIN7vVcj0/2moqPTZyyXIuJYmGKuvRzl/QLlnJdKmMsygp6nJfOlfQVhiq+YlPUaOLn93Ch9E6vupwFLm4P5lxU3LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7QGVu9Tclb+DXBrYTp8+Jhu7oCZMOQxjDScMUaUhEI=;
 b=YLn4HIMAfnlFiQu5iRwfn+NBUEV8199Gu0IMqt3xyo2ZMVYXpYwP+ABSldjkcK91lj8GhfsUxjbQSr5xXEiBsX0/orLHYAk5LPFXJdLiQRqFe+FlwjUAHJ7gOA4DUMej8uzeMzCu0iW9SNxSGo5xAP7l4umgg92M3L27Ubb5xsfXskdSxBBDIQ8NTWJB8DAkR+0yrG3yAWG+jMYbxutHgikL68MJchjJYlA/owh39aW73yNrrCeK0F3drQgj8hdaUv5Baw8cOoGIdYgAJu2quJnTx4YLtorx8Qsfgo8ae0eHWvnxRCrhzI1Fes3ZrT1DRyn/y600cUqbq2dBWqTwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6058.namprd11.prod.outlook.com (2603:10b6:208:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Wed, 1 Mar
 2023 03:28:04 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 03:28:03 +0000
Date:   Tue, 28 Feb 2023 19:28:01 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Programming HDM decoders
Message-ID: <63fec6416db0d_3f3f429478@dwillia2-xfh.jf.intel.com.notmuch>
References: <DM6PR18MB28449FE11B645FB3A3CD3243AFAB9@DM6PR18MB2844.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR18MB28449FE11B645FB3A3CD3243AFAB9@DM6PR18MB2844.namprd18.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: af415b4d-a6b5-48a8-d057-08db1a04f747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBudyF5TFC4dprhX/tBCswXeRQzzWYiM7ZDf5EDPusTmscd4pImjkReheRa+GJqzpg9DX1X+64pmv7nTeF4bIk267HwXP0dq/iVvjA+OXKTznOM5y0WT9Fhj52iDOvo9agculF2IHkKxrgTcY/kCWmyY/fF9UKMNGTKc2HXch9ykP/5KlmSbDNCMm6z064af9XUk2wVQq76+bI1ljrHV4dM13WXIjymOQsa5oQDIzFf45lk3ZwxwQHw6qAuimc7kzdEkiORRDkgEXsxUaZYPKDiCuqfYMD8AlLyYVJ3W2VN/YHTuZ5h4O9PgPzE4Pu8TSIXbriXUq23Y/J4L8sE+1s3K+d4VY/zpJXVqZCkY3V/Tzi9lB39M5yau0ZB+26UWK16Q0+GIRBPpMtr7txZnI/dd7UZeDT8fdV6cJc9MqZTWr7ZB5+gJvG9MMVB2rInCUkF72E4/sOd5Cc2nmdwEGIzQb5jzZ1dt0M9ZsawygNFiYJCkWrV9aexiBefL2KzTpwLgpiQBUvGLJ6dQsKFM9nGIqQr7reroYjHtVoB5kRKw0l3YGgoe3NsayRzAQxogsekMqbvGVVc+BjQWNxHLM77D07W31Y68Ak4V1apgEGe/WgLAKhOaB9wj33h8TXKkbPy4dr0Jlu/amrZ97ZhnZufwXMQEhZmSJagkOtapbkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199018)(6506007)(66476007)(6486002)(966005)(6512007)(41300700001)(8676002)(9686003)(66556008)(316002)(186003)(26005)(2906002)(110136005)(66946007)(7116003)(82960400001)(8936002)(38100700002)(86362001)(478600001)(5660300002)(3480700007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUVORW9kVkl1QStTOFdWa0hHUWl5eDJuUnVFVGhSODFzbUsxMGVVSmdENlZo?=
 =?utf-8?B?ZEhuRWFmSTd5T0JCa0pmRTl4T2hJTjZyRzNoMnBiMHJJTEhmRSs1ay9IT2Qy?=
 =?utf-8?B?aGJtYnRhU0QyeDZlc3g5cFc0UHRlSDV0VHlnVlNneitqVDZBbUNWWHFGUWFJ?=
 =?utf-8?B?eTZHbmY5U1NjWFF1ZHRBL0ZLSlR5N2ErYTBzcmhHdjB0NGw4blNUcG9NMEdF?=
 =?utf-8?B?a0NvRXVMV0wyQjNHdjNRVlFxK3pvWmVJTnh4c09oVzhhOGN4WWlLUlg5V0dr?=
 =?utf-8?B?OU1od1lHN01yVnpCa3NpNk1FTnVHditDMzNQM2RSczU4b1dMMjAyaFZzUmhw?=
 =?utf-8?B?cGRTc1hDMXRVZDJNVGw5UDJVbDZlVlNoZGVFVk5Pek9ONnV2L29LeFZXRTFK?=
 =?utf-8?B?OG00WVVoNzBMNlFZa2xsTXo0Z2tZOEx0Y2M4L0lXc0ZsWGxRVkppM2gxa2pV?=
 =?utf-8?B?a2svdFgrTEFBYlFVWUJEdytlMFBuVkdsV1ZCSUFIZHdFUVBDa1BZbkFpbkJY?=
 =?utf-8?B?NUVId05BY0RydVlPbDFPdG4vN0FzeExTOHQ4ZjUrZ0NjSHVkSWdqNVNWT001?=
 =?utf-8?B?eTVXZWpLNEpyOWt1Ynh6U0NCSHA0YXNnaFNzdU0yS0FtYThybGlYcTFIRWJl?=
 =?utf-8?B?Y0NMSzB1ZitpZVIrMUVweE5qMWI5amxYUnE5MFZHeUM0LzVDSFdaa0RkM0N3?=
 =?utf-8?B?T2U4K2kzaHZzbnNQTWd3bkpKeWpkRy94NHZ2blZKT1hiWFNJRWQ4WHBicllz?=
 =?utf-8?B?NUFUUGlWeldOV3RtdEJkTXBHLzQ0MklOYW1IaUdKditKMUlXaW5OWStIYnhD?=
 =?utf-8?B?WnlLNXNCd0tjK1BzQlcrWVhDM09TbDFnWUNkUXMxOGtlRDN3QjNSd0NTQ1Yv?=
 =?utf-8?B?SWlCdzAzOGkydUpvQUZCSW5ScURnc1NhdllZWWdiTzRoZnRuc3ZMTG4zVUhl?=
 =?utf-8?B?eEhiRVdUQXlsaDcrbFNKMUgzc3pWWjF2cFBXdG9tUmY3cUtUZWpRQVlXQlMx?=
 =?utf-8?B?bVk1TGNjcnVJZURBOGRMbzVIMGtnMENZa09zSzVLYnBvenJOb0VVRENUcUhj?=
 =?utf-8?B?YjdVMjl2TVdUYTFJSjJsMmJPdGQ0ME5BeDIwRXNDV3RVMjhmTjZXS21CYWls?=
 =?utf-8?B?RWhZenVkeDgxdnRQaFVGSHVZbUJYaHVCc0J5bzFhSitUOVVwazZKQUVIWmJQ?=
 =?utf-8?B?VTVNTTNGUXhId0FUTDA5Lzc5NVpWZ3phMy9VZ05WM052RWJPcmJZOG1LNS9y?=
 =?utf-8?B?MjlnZ3NEbXpWYk9EOEFOVW5abVJCV1I1eVhOeE1iWlQyR0xLVG8yNlNESDI0?=
 =?utf-8?B?bU5IcGxzVXo0cWl2Z0pQWVNid2g1NFJ2VlhvYjl3eEdCTEJQWitCOE1GSHlP?=
 =?utf-8?B?NU1zKzVNaEN3Mkd1Tk8rYWRqSnFybVFGeWRWbngzNEdzd1IyT2RHWUVqeG1z?=
 =?utf-8?B?bkQvKzlVWjh5Q2xBYklyMUQvWjZIN0ZwVDJ6dEc1TlJFakxsNDNkdmhWajRh?=
 =?utf-8?B?SEpacG9hYmUzaWd1eFlJbjhDTFZFMjBzODNmM1gzcm9MckU3ZFM4RXdMTVkx?=
 =?utf-8?B?d2FzcSsveWhsdmZkMjBPRCtBTGw3b2lWNE5GTDVpS0p4SUVTWmhGU0ZIaXpV?=
 =?utf-8?B?WVRMdm40clhTaW1VRy9heUdrNEtzL0c2VGhmaytNZG1xUkxub0F2T3VSYmFo?=
 =?utf-8?B?K3dVcFFxUDFhOTRtRUpic0xJcmZTWm9nL2V1dFpSdlFENUtIbnArMU5OWVZo?=
 =?utf-8?B?dGVRNDQveDFKV2hvelZ4YTlBb0I3b0lrUnhMc2lRMDV5M20rbks4TXRMUnVt?=
 =?utf-8?B?N0o4d0NpQm5GS1BubU14dzB1TDlpdlpLUjVJNDF3bW1pSEJVTXp6eFJjRGQ4?=
 =?utf-8?B?TXI0dFlzNEJiMUNRTXJUM0wxR1J5Mmp3aEpMNVFxLzUxQmlENEVWUk1zdkxZ?=
 =?utf-8?B?MWRhQjJBOElaS1JKVGhiTHBodlBKQ1RKYjNXVWN0SjFFa1pZdlUxR0RCcEVU?=
 =?utf-8?B?aGo5NVRlWjhTRDYwMEdBWWpaSjBIdFpEejhwZEhYQk1KL2YrMGZXV2YyM29Y?=
 =?utf-8?B?OE05N2trdnRVTHE3NWFWSmxmVGN1WEEzSC9PbktMb1BUYnQ3blN0d2JDa1pC?=
 =?utf-8?B?NTM0NytWdC9HUUhTT282bUVIVVRhSjBOSWRNbFFCcU1JNXhyMUcxWlhlTGFH?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: af415b4d-a6b5-48a8-d057-08db1a04f747
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 03:28:03.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RUPPaMh3zU37wYqqx58HthhpOtdIEOwA1GutdTlBUPP3Pc/h4U7xj9mcioojiUR2CEM7qhvA17d8eylpdVZoCYsTTMyvXu87oeGTbSitF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6058
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Shesha Bhushan Sreenivasamurthy wrote:
> Hello all,
> Section 9.13.3 of CXL3.0 says "Program the HDM decoders appropriately
> for each region’s base and length from Get Dynamic Capacity
> Configuration data" and "Get Dynamic Capacity" which contains the
> start DPA and length of the extents. How is this DPA used in
> programming HDM decoders ?

See Figure 9-24. DCD DPA Space Example. You can think of those regions
as similar to how the driver handles RAM and PMEM regions. As far as
programming decoders the flow is the same for DCD regions as it is for
any other region. The distinction for DCD is that the DPA assigned to
the decoder additionally has a state of 'populated' or 'unpopulated' by
extents whereas RAM and PMEM are always represented by a single
'populated' extent.

The decoder programming flow is described in the cover letter for the
series that added region provisioning for PMEM:

https://lore.kernel.org/all/165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com/

Another resource is the source for "cxl create-region":

https://github.com/pmem/ndctl/blob/main/cxl/region.c#L544

Lastly the driver-writer's guide also talks about the region creation
flow:

https://www.intel.com/content/www/us/en/content-details/643805/cxl-memory-device-sw-guide.html

...see Section 2.6 Memory Provisioning.
