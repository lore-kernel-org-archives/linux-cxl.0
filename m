Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BED2EB64D8
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jun 2023 20:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjFTUda (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTUd3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 16:33:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ECA7F1
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687293208; x=1718829208;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CtE2ssMYbB8GtLT+ejEv6Le3bxANaBfLpjaWhf3+Sho=;
  b=hGkIX5fOK2mvSHJ8AgmAstwcv9qsUDCahy83uZypriA0YCm+O2CbuDpe
   gsGWvJ5pHZqOSoEfw8Z4s7vBhiawqun3QNYHcuOGu3tY57n9alWDa49V1
   2S6Vv2gRZWERH9/xtFSChrsoHJrwMgsmKZhafXAijOMd4382y6H3Z81QW
   bBBsuO5pdelaIIqdNRfg4whcS9A0ohI4pcVepqYUOCvTyhIrLZjQNKKPY
   +w0z/n3OawhGiODfx4Dno8Z8GUxR6GDkJGqZ27B8F2INxTZM/TEdYUkeo
   G1DGvy14tBVFfsgBXUL+tbDzNXWH7sNRXpzNLuiVA3wWduZHq/Cjxdz1o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="359986045"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="359986045"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 13:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="708427121"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="708427121"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2023 13:33:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 13:33:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 13:33:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 13:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPAgkjAorgZlKVBtpeN2g7dDay0yZrptk/gwXg4U5VQv9ODE93iTB1e3NxWPQou0DR2m+U9WqiRIbvf6fW26WxuDbjKftFYRMcV01itDu161aKuoG9SLxt7ndGyW+tspcFwyaPCt/eVSfxM8d7gdN9vBQ9/O/+9o5R/hjp0xk2Z25jEF2dhS9XM+oCyJFnEp2aFytYMTcqRTFDdRa5n0y78fIy3hFNMF6cYnMhsnZgLZLQO5uYFCOpic448EnUYlLcBePHHqrKo8qT4Ym9ijB3hQWLJHIzH4v4f0L2QKEf8swHgqM+MC1CfGJGWpXbUqcnLDrc0zqr5xRBXt7L4rLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTgJTrSrkCoZzbzQzy++iV3liVquu47ayY+/44T92T8=;
 b=BPmkjTaD0tdvBwsGWsXAQKYYVGbT5crwW27G7cD3Nf1GVu6yjiq4WnO3QcpUa7T6g9SHYn5PbeC0zrOIh/AxWmkMluUuauq4tSEeDOwDIp1ej56goHe0ccWJ8iSpc07XHvaEqwnzGmRjv9f2xO6Poxg+3r3v/F0Vca6OZTV6jFu14Jvr2XjtJKQbj5voxMEiyb7mrzg2NREpsHG2HCvuePQByCmxnaA4tzSdysNZ+QpLv8IP3C0gsO4tRjytoGhMjGEgsjFYF0hotFJnhIZubhtH7W1JM+Wjiiyjn/gANBvPo4G8dOjU7dtOqpvAkJ65EyZUVEdkewbA3rjm7AzlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4641.namprd11.prod.outlook.com (2603:10b6:5:2a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 20:33:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 20:33:25 +0000
Date:   Tue, 20 Jun 2023 13:33:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <nifan@outlook.com>, <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
        <nifan@outlook.com>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <64920d099d669_136e4294b9@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <SG2PR06MB3397DD960E58B1F026CBC0E8B25CA@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397DD960E58B1F026CBC0E8B25CA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: edcf1d61-9f85-47ba-74a8-08db71cd987d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNO83AiT1S5zh8HqmU0VZXL0G5OqjCO0R+1mfYYTMBFAl5JKoIxTSbZtcdcZTPZ+++dL8D99/Z7u3wRhFEdpwYozVteQyqcg+LFuEAHcUFyHLD6H10GwJZH2+3ZVcoUN0SXQhNSSWdcne5gfB6Tee8tRRVDwFVwkOS02vfMA9TW+bVF4jZYx8Vbk6842kMyHQLc8xgGOLD0w4eI1hnk25VYi7fV4SOXMI7zqxC326iPFcyEI/t6RxpHqC2yM/En/S4gOeoRtCvhdFE54LxD1VycZisbMTbI75Enp77elt9OHLax2KTjTSr6kdnAV0sgcL/ZLyEyUYatG+OYVqXCoCmrMMdMAXFL7aGQY/w8soa+J/a/FE4a37EFhtcoD7GMTmOYNIxvbac8dNmEDc1zNkoDeaIyk/OHXf2yDhY1FIcD9OWv49pP779L7gHLV/OJtmdmcL+J6XZ27UJxOZlmWf/xWLXaimqHuwZ8w5N5uydyJp1Xcqk1ny0GWXuajiM9gW7HUwvTEjg5ZS3D6sD/oIqQ/dccI8+ET7BPXb8aNAH91PIgKf8gpDo2rdDrQXCM/7uCM9za6Xjg+Z6osEiAwhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(186003)(9686003)(26005)(6512007)(6506007)(82960400001)(38100700002)(83380400001)(6666004)(478600001)(66556008)(4326008)(41300700001)(66476007)(66946007)(8676002)(316002)(54906003)(8936002)(966005)(6486002)(44832011)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jmvy3sx+QVG58YFyt66UzkIKKMhl1915eZUyKFUamGsOZiqRdDaQGEg7pBtT?=
 =?us-ascii?Q?iJmkYGVgIv9Y0madkF56H6CpY04z+W+q84m4nHJ/2TIuEMqAkFoJOpqFjcHU?=
 =?us-ascii?Q?ndQAtaQorjyWoEGU04NKVvEx0I0HA46ioAxR7J8Qv/wW7RxqEqfWDkAB4hgi?=
 =?us-ascii?Q?FntIlawuiFSOFtrqsMbCNBUBCqOVzbArUggM7Vk9+EXDbCQjZw65fbZRvoK7?=
 =?us-ascii?Q?Sff5si4mz4OdutX/JX9MhLJHDiwuJrt+qhtUmEVl5nEHvfXCxR59y79fGSvH?=
 =?us-ascii?Q?XaQi3wN6UfMYLoWFFGUx1aW6Mz2N69yfJ+I/6mjLqsMx6iB5WbGGq24DlXXe?=
 =?us-ascii?Q?OkJijR2kzVDg0MW/NOn5m9ZBa2cbn5tt8Dj9ZPm8JWJwzDufyqv0XYH80KfY?=
 =?us-ascii?Q?+R2jf8fL1GIQTQMHPm4uUpQPfYgBGSIHSLnKWTx+XARePFshIfsgDPQ73331?=
 =?us-ascii?Q?3cw1dYLhE9oE2rMs67TlUpdPixzb1/mF0RDsVD7c6k8hnJBqn5oJMo8kpsNz?=
 =?us-ascii?Q?xFlhw5IP1iLlhsO09CQm+MI1KjrkhMC8uSWk+FAcmEWZ9OB0oYNvBPBwEoZI?=
 =?us-ascii?Q?m66xLXIDVuibsDaTaKiZf91haS7kCn29l8qSZ4Vsy4lOL22p21nHqhkRBcTW?=
 =?us-ascii?Q?bdv+/BbZUsPPPHN2MsZphN67xC5mF2Y+hoIFlm4dp3MVAO0BI9RAG5etOZvA?=
 =?us-ascii?Q?LGF2c8a25kQgFNFPeVpIaz8j1ij/f3Y98+u42pQ3YsQOpYBOtsKKjbFW0K17?=
 =?us-ascii?Q?PAZihWEnJsgTBasdsH6ihOSDriU1NHFVNvx9DOexRMk0flDtj48csYMpNW9t?=
 =?us-ascii?Q?rww/OJd4jfrtz3NXiZ2l/61AKyF+gEz0T0GmdBAYkFU0DgibcDmRdVyKLbFs?=
 =?us-ascii?Q?righTYqxQ3BEYDPD/ur0fKfQ5MVj9Cz0pEDgiej2s+9N2zGaX3JL9xKhV0/R?=
 =?us-ascii?Q?6uYO0ssYyJzj9lRqEQqrMWON0KgqGFqJIcQ+E9OBtiLOz2/mk014hXN7pfx0?=
 =?us-ascii?Q?tZDJ+WTlfwxGjAs5Bs/GtFzSP9A/GLsC7IoEY2zKMz/NJMwUI5vpN5c0Hno8?=
 =?us-ascii?Q?SWrj91H0f84fZR7pct5kM0iGbIty/mCPqJ1dSeCkWa8osVewNOM1fVuuX38y?=
 =?us-ascii?Q?G3Gs1og6Ljgkyh2+YzJmMpdn4Bpvpb+ck7vqnzOFqn1libXqL7Xc4v4RAz4A?=
 =?us-ascii?Q?zanFxXTITROFzalrq5CUeW8bQt0WTwWf/GVTG5G5nthqLlJmYF5d4LrbAbu8?=
 =?us-ascii?Q?6p0lW3Z9JQ5+9TinNLWErG4A3deA4hA+9kGMUL+7a3Fvnl/1RNZF5HByUb8Y?=
 =?us-ascii?Q?m5q9sFz+SdaBAKxpDb/dq1gV83N7w9kuOTNJqQqgFPTK1TZxWq8L0SEIK8U8?=
 =?us-ascii?Q?IyYjypBFLZIXl+GRBRipCYdc6Fkhr6kX9jod6d3JvDR4b1Et3J/z63aiI5tf?=
 =?us-ascii?Q?1IcvSKx6kiKOA/pF3QB0Y7n5hjOK2ky4MYbhDctOdZl5czwqGfrpCM91V1/J?=
 =?us-ascii?Q?UtzJX+iOh8xOvno59XoZypJoqq5H7Z9/85AMWyGchii5xWcYprX36hxS9ei9?=
 =?us-ascii?Q?f6Zw/3GLQRcl7Xyy610Snp9PSku64rhJUz8IIlfN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edcf1d61-9f85-47ba-74a8-08db71cd987d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 20:33:24.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ety9+42hvcCsQOXRAkZvGo1J0i5b7t9ExSBUCzKXzusQryZP9EeFTwn0eHBCIbXI+QU+4l4tidhDnrcjhmcMGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4641
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> The 06/14/2023 12:16, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL devices optionally support dynamic capacity. CXL Regions must be
> > created to access this capacity.
> > 
> > Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> > Dynamic Capacity decoder mode which targets dynamic capacity on devices
> > which are added to that region.
> > 
> > Below are the steps to create and delete dynamic capacity region0
> > (example).
> > 
> >     region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> >     echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> >     echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> >     echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > 
> >     echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
> >     echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
> > 
> >     echo 0x400000000 > /sys/bus/cxl/devices/$region/size
> >     echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
> >     echo 1 > /sys/bus/cxl/devices/$region/commit
> >     echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > 
> >     echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >  	}
> >  
> >  	if (skipped) {
> > -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> > -				       dev_name(&cxled->cxld.dev), 0);
> > -		if (!res) {
> > -			dev_dbg(dev,
> > -				"decoder%d.%d: failed to reserve skipped space\n",
> > -				port->id, cxled->cxld.id);
> > -			return -EBUSY;
> > +		resource_size_t skip_base = base - skipped;
> > +
> > +		if (decoder_mode_is_dc(cxled->mode)) {
> > +			if (resource_size(&cxlds->ram_res) &&
> > +					skip_base <= cxlds->ram_res.end) {
> > +				skip_len = cxlds->ram_res.end - skip_base + 1;
> > +				res = __request_region(dpa_res, skip_base,
> > +						skip_len, dev_name(ed_dev), 0);
> > +				if (!res)
> > +					goto error;
> > +
> > +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> > +								GFP_KERNEL);
> > +				skip_base += skip_len;
> > +			}
> > +
> > +			if (resource_size(&cxlds->ram_res) &&
> Should it be cxlds->pmem_res here?

Yep.  I think I mentioned that in the thread somewhere...

yea here it is: https://lore.kernel.org/all/648b548db05f5_1c7ab42944a@iweiny-mobl.notmuch/

And Navneet agreed:  https://lore.kernel.org/all/ZIte4QozSm+n2zI3@fedora/

Thanks for looking,
Ira

> 
> Fan
