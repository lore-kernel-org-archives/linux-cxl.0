Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4E0C77B71
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 05:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDRFvw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 01:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDRFvu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 01:51:50 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E51469D
        for <linux-cxl@vger.kernel.org>; Mon, 17 Apr 2023 22:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681797108; x=1713333108;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gfEEHmLUkeYcK+MwNcL23fZXUwl9hPcXUAjeSUBj3Kw=;
  b=QoHD+W5wo+9R0pCR5MznZHikQic+29iHO42l/ULz14RtjTzVymAFRDpq
   h8536DMOJ404wyZZM6Zs2jq9jHc1PeBhccGVxQ2Diup6oZoYZeuc0yDGr
   EAUsPt797ork/u6YI1xRfPrYTEP9qN5V4k7PO/e2UPfbr5QOpLS1MpMae
   k1AJAx/fufNpRDtvRZlh/TvIgY1U4s8qEnHqT2FoUgHBq0i+nYAxCN3S3
   GnmZzML0tEIfhv4TRsr8my3e4pk34z5CswwpWjxtudVkYLKP5nPl5OTFx
   b8tnSzs77sETLZlap2bn8jDog255PfffaY5JbuIB+IpyC43NdAlcPZx8C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410301973"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410301973"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 22:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="780383858"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="780383858"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2023 22:51:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 22:51:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 22:51:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 22:51:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8UTKUUfYDxYFrsHOxixMlUcl2mfNvhU9ITvoNhWGFbz6sOvMk4zVRloaVx2OTOwDYhT8DxqIdxGJZ8ct9tRZBIrZWjuLCXmOob86nOXAswqVZpta+A8EoqncMij6/ctPIW7IFSLYG2ijFkqnsuDTW4CAn1qEtxYc0QncGloSFXgYyN43S4GS1Uj7GNvO/ldXo3OhNFSKCqf1IgEwVKX2H6FmwiQNkjBcfhMmX+cEmskTdwDApvqdRjvdDEMVGP7xLobEbc86rAdBc68c/D5dDRufc2wiLDKREVBJ23RaKtitu9X/71uvU5yMaSW2zMVE2NIwjs3WGM/4m4YSGsCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JXbWx9oJBSB9c9U6AiTgPNOriy+kpH7PVCgUdY3bDQ=;
 b=gBimv+sNW7mkCyb8L/SGJoNf+x7UUr1kxr+leeABZ4lpmtgTn7r6giorn+UKUy1Nd63vr5ccSLOE0aANFlDtJvLLqC41c/2EkOcCdylIis0QraGAC8u1n97e6tRSPstX2i7yGdDnvNMNNNwRk8tTOUxHRkC1LY+/TEJTpdlo85T7HGHKuJWPXBjRUPwnMxI5eoxumKJHzKJGDb6JGcJ3pZToZNWn266hjaa8B7lEQO919DecL3MonNdEp9NXvtGuoezWlnYHp0UXM2kIEJOhRyuZVMThHfXGJwqq6Y4YVoQutLfPxFRwPTeaL7AlIBdITy7spC35+alMxu0m6SJDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 05:51:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 05:51:44 +0000
Date:   Mon, 17 Apr 2023 22:51:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <643e2fed87bd3_556e2941b@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCRzh0VLSVF/7jya@memverge.com>
 <64252d214f0b_c7222942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCUPlnQYVRCumy2O@memverge.com>
 <ZDtz++B25suuoYoY@memverge.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZDtz++B25suuoYoY@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: ad46307b-7bd6-4a06-8407-08db3fd0fd53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPq37NbodO2cnej1XbaOajAFYMJbyn+PnARvZZUWGFzkwLELUGUavzjyaDhtTlkBaKZhnNT5dkjuf2mZMGTIzPnMkKLpUnIawQO+q3/9TRYyIuvNJEx9sPE92IbHkW6KZ0733QnKX9hoTd6/R5c6Vuk4jAoKd+Y19dDNrcJrCeMPs1GmsuBPry8BDjToY/+3VpqHFJkJ0yotQFvje8EL/0GwI3iiRzgh2sR/UTSesAmuwt60Q7UfxWSwJskuBM+U+M2DyjTiLAIG+NOe0jXuZhSICmCEJzpPw4ZfUs/TxMKe5LNyr4a9WrWFVhQDbxCTjFe6Bi1vbgwoD3Bz7+N6DWTTMFoyOY17HatCrQVEinK7OE/Z4CRDs6J19ckb22KfzZFwE0cSXF8dAVAlLt0oYeGaQT/G7Ew8GF1frNyi1I0arCn15s7TMkGJWoiLq0SNPTKfKuzPuuNVZTOLIbaHp7srFSx3hv6jpsDIeDt9vg7Z+RyH+gJuhGA8AqhaPxVehsFnB0cu+6uZ/VT9voveAfgUntKA7Ppy3UwQHZj8LoG9iVSgDvw1y1ZN3l8UK8h0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(376002)(396003)(451199021)(38100700002)(5660300002)(2906002)(8676002)(8936002)(41300700001)(86362001)(478600001)(110136005)(26005)(6506007)(6512007)(9686003)(107886003)(186003)(6666004)(6486002)(4326008)(66556008)(66476007)(66946007)(316002)(83380400001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1h6d0Nab1pZRUxFZ1QrSlkzYXJ1NkU4UzVtMHBmZm5BR1VzYW9oTE1Ia1NP?=
 =?utf-8?B?RWNMeVhOWm9pdWhaNUdIeHBrRUlwMEg2UTVYMmg3NEc1NWhuTmVGdllzdG5O?=
 =?utf-8?B?elZkREVZUDNQcisrZWkvRmZpZUNrNFU3ZnN0QTRka01FVEM3TENOL254b25j?=
 =?utf-8?B?bFI1N3RETmNWTCt2dEZ5eDJGcGNuZ3lKZnBvUTBpdUFVelM5Y3NWMlRXM1Fl?=
 =?utf-8?B?eDYwaUQ5N2R1K2RlTlBick1yRzAxQ0kyc3JYZXJXaEZjdEZTT3RTNlNqNnJq?=
 =?utf-8?B?UHpCbHB5dkRLcG1SVTRBSmc5U3QxQ2tIWkdaMitpZ2FWNDF4d0JNbkc0ZFVv?=
 =?utf-8?B?VzYwZmYrbVo0RkJjR2xDQUhMSk9xOHMrN09HQTdpVzdDNzdBOVg5R3FJZHZy?=
 =?utf-8?B?RGsySjlybGtkUTN5MlVza3ExNHZKQWtucWdKUnRrOUJLRlBGeGFtSjhReDQ3?=
 =?utf-8?B?aUZ3dk5tOXkzRk02aFVWa0ZTZXJpQ1QxNTcwUmgxWEtrbzFoVTFIZVJENEkv?=
 =?utf-8?B?QW9JN2hNMlpDNDlpbUtmS3hUeW1GV0dRb2MvenNTMVNwT3EvQ3pBekEyUmcw?=
 =?utf-8?B?bEhCOWJhdy9IMlRvYVhjd1Q0OGMxY1hhNnl6TEVtQnRkL0JIWWFHRXF1eWEx?=
 =?utf-8?B?bGVTTTE0Wi9FUE9zdll5Q0FvN2syNEZMQUFuUnhVSFNqWWwxQVJLeDQzNDFP?=
 =?utf-8?B?VFYrWWRUTkVzWmVXMjVyam9LUkhxUzZDRjBuTE9ETUdiVXc1NUdwYnk1aTZB?=
 =?utf-8?B?UmVwRnpKVExmbCt1TWtnY3FjcW9xZnlZMmVFTHJJNzZkLzJVMHVYZlJVbDVM?=
 =?utf-8?B?K1JNc3RTUndkNGtPWDZJanltdE5IQzJQZG1PNDdTZnZaUXp6MVNoWG1pNzV6?=
 =?utf-8?B?eXpNOXhZN2NJMEcrVVRWQnJudnRCUlRzRzd2djJrWHBESXg1VDlFeTZsbGdM?=
 =?utf-8?B?WWF1dHJmNVlEcjZLdndZdHR2TWY3NTAxQ3FSbjV6Vks5VDZWRVFKU0IvN2ds?=
 =?utf-8?B?TGhQMWpENzhQc3AydHc1RlJVQ1Zyc2x0c24wMkR0ZG9oZ2R3K3hjSWswRU5I?=
 =?utf-8?B?N3ZZOVdKTlM4MCtRUjdqcTVCT3J3U1FXT29rOHViZEpUNGZCak1veFNWMUZS?=
 =?utf-8?B?dTgwWCtiTm1taWhzcE9WdjdrSFlNNEt3SXFQb3l3ZGE2RHlCUW1hektjbkdt?=
 =?utf-8?B?a3FHc3F4djlmb2tHSkJxNDRNQ2JDQVNDbWhJdEFZa1J5dlZySzU2andMZ1dC?=
 =?utf-8?B?dE5FQlg5ZnlZUjlHUndLRFdGaFFHcTBCZDNQM2ZFUFhTVnZYWFRsbXN0SWlN?=
 =?utf-8?B?QWFRWlFUK0VXa1NBbDcxb3RYN1g0eG5kbDl0R2pkSlFKRkNqWTNUUndFT0Y5?=
 =?utf-8?B?QUpBQyt1aVFNMDRzaGZVbElYQXR2a1kySFZvZzdJNEFBaUoxejBlREVLZm0z?=
 =?utf-8?B?RmU2TVB0T0E1YjhXQ2dPZThtNW4zeHhnUWZwZ3gyT2h2anhGRy9yMHpCZmNv?=
 =?utf-8?B?dGdRQXM2TDRGK0JNVEo2MlJUc21WVmdWcHNReWZ0QjlvMkMvQkVkTW8zNlhO?=
 =?utf-8?B?YUtNeHRNUXBLZDI2M0xaWUF1UkJEcndGSWVSMC9TMXZLdkxHdS9SdTB1cXRG?=
 =?utf-8?B?MlFIUmVTZ1MrSzA5ZzdtM1dKSkJMR0I4alpuWlM0YmtBNlI1dTF3TkdMRjJl?=
 =?utf-8?B?WXRNQjdFWkExbmhmQ2NiT1dmYWlBVHRDOVc3SXFJb1JVQ0NaQ1BtdlJ3Qm11?=
 =?utf-8?B?ZXl2VEZ3ejVNOWQ2TEduMzVuV3QxcnJXeUVycVhvVFJUZDhtZURDRTdpSnlK?=
 =?utf-8?B?QVdGVDZtNWc5Y2dPZFRPdElkd2F0YTNmRDA1Z3o3QUdVMk1Vb1o4MU5CQlBj?=
 =?utf-8?B?Q1UyWXU3SlQ0cm85cFVpVmswbnJaOW5oVk5HQWsxLzBmTHRwSFJJN1JHMDM2?=
 =?utf-8?B?cUxrbDhuZjJjRFlraHRlWVlVcGswRFRERDhWNFJUam9rNGt0eEFpb1djZmxZ?=
 =?utf-8?B?Q29Ibjl3WUZ5bXlYVVJLaGZaUmZ3QnVnK3FMK3Z1TDE2L1d0dWM5OFkxcXRm?=
 =?utf-8?B?VTltaWsySTRKTGpBTzYzeXd3N3ViOXNvL3p3dlJqVFRsTEhDcnNkVzlLRVpH?=
 =?utf-8?B?WmJPNEV4SnllVG16b1BLbCtHUTY4SE9hdTZqQlptcFlnNkR6N0c3SXBteTdS?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad46307b-7bd6-4a06-8407-08db3fd0fd53
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 05:51:44.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4K4YO3waCspRmpo5lb3lUf/a5jEnFznUBPkchEsa7Kx4NMrMMdoIjfWcnUTBtzkYAyBwhoXVXHRQt9RJb1R83/83rIrP+EN9BFKExhU0j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Thu, Mar 30, 2023 at 12:27:02AM -0400, Gregory Price wrote:
> > On Wed, Mar 29, 2023 at 11:33:05PM -0700, Dan Williams wrote:
> > > Gregory Price wrote:
> > > > On Wed, Mar 29, 2023 at 09:21:25PM -0700, Dan Williams wrote:
> > > > > > Is the DVSEC Range Register expected to be programmed by bios, and are
> > > > > > not being programmed correctly?
> > > > > 
> > > > > This debug experiment makes me think perhaps the *device* is at fault,
> > > > > not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
> > > > > to set up the decode as expected, but reads return 0? That's the only
> > > > > way that I can see that forcing that offset results in successfully
> > > > > talking to memory.
> > > > > 
> > > > 
> > > > Oh, i meant to add that i tested whether the memory is accessible via
> > > > numactl --membind=1 with both memhog and a python prompt, and things
> > > > worked just fine.  So memory works.
> > > 
> > > One other theory is that the device is correct, but the platform CXL
> > > window accepts transactions at an offset and then removes that offset
> > > when transmitting the address down the CXL port. So device thinks its
> > > decoding 0x0 and never sees the offset removed by the host bridge.
> > 
> > Wouldn't that be against the spec?  I thought the device intended to
> > receive HPA and do its decode accordingly.
> > 
> > Otherwise you could have multiple devices programmed capable of decoding
> > 0x0, which is already the device address, so there's nothing to
> > "decode".
> > 
> > I'll follow up as I learn more, this is concerning.  Certainly explains
> > why every time I switch hardware nothing seems to work quite right.
> > 
> > ~Gregory
> 
> 
> Follow up on this:  I attempted to actually write Memory_Base_Lo/Hi with
> the appriopriate values, validated the write went through, and then
> utilize the memory.
> 
> This test lead to a total system lockup, implying a major bus error
> and/or device failure.  No stack trace or any indication of exactly what
> went wrong - but it's pretty obvious there's a device issue.
> 
> if you remember, my initial test was to simply shift the base to the
> base of the CXL Fixed Memory Window:
> 
> @@ -342,6 +344,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
> 
>                 base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> 
> +               base += 0x4050000000;
>                 info->dvsec_range[i] = (struct range) {
>                         .start = base,
>                         .end = base + size - 1
> 
> 
> To this I added some writebacks to the registers to set them what they
> "should be" (i.e. what the BIOS should have done).
> 
> 
> The other thing i noticed was a combination of DVSEC flags that seemed
> interesting:
> 
> DVSEC CXL Capability: c0de
> Mem_HwInit_mode == 1  (harware + firmware on device do init)
> 
> DVSEC CXL Range 1 Size Low: 804
> memory_info_valid == 0
> memory_active == 0

Is this CXL_DVSEC_RANGE_SIZE_LOW(1) or literally "DVSEC CXL Range 1 Size
Low" which Linux calls the offset CXL_DVSEC_RANGE_SIZE_LOW(0)? If its
the former, it's valid for the second range to be disabled. Linux stack
should have failed cxl_await_media_ready() otherwise if this is
referring to CXL_DVSEC_RANGE_SIZE_LOW(0).

> 
> So this appears to have been BOTH a BIOS *and* a device issue, but we
> should also be checking these bits before using the info from these
> registers.
> 
> 
> 
> Something to note from the Spec: RCD Discovery (9.11.6)
> 
> 4. If Mem_HwInit_Mode=1
> ... snip ...
> 
> - Each HDM range is later exposed to the OS as a separate, memory-only
>   NUMA node via ACPI SRAT.
> 
> — System Firmware obtains CDAT from the UEFI device driver or directly
>   from the device via Table Access DOE (see Section 8.1.11) and then
>   uses this information during construction of the memory map, ACPI
>   SRAT, and ACPI HMAT. See ACPI Specification, CDAT Specification, and
>   UEFI Specification for further details.
> 
> It also sounds like trying to place this device in dax-device mode isn't
> really the intended use-case, and if that's the case maybe that should
> be disallowed?

I don't follow. Any CXL.mem in the end is just a physical address range,
any physical address range can be passed to dax or the core-mm.

> All this considered:  It's still head-scratching why shifting the HPA
> read from the range register successfully produces a "working device",
> but I suppose that's the definition of "undefined behavior" :]

The needs the platform vendor to weigh in, but that may not be possible
if this is evaluation hardware.
