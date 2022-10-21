Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BD1C38A2D
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 21:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJUVRS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJUVRS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 17:17:18 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DB013E21
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666387037; x=1697923037;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BTZwQ6M1cUAwcDZMI4DKdlRIkQM8BOnyJpCClE7YBXc=;
  b=ZvPc3rX+X0rRCq5/ZTi6Ir9QlTTGRDHk12vV0bEJRfxm2HT+mvPxxcFF
   00X3TPOMuRSxJAImpmfwwU3vVi0yipej+1dn2fjoKqfItqWuWvL13oQJz
   9SieR1WE71OL3lL3ymYL3DgQBYgUJ5h9ZPreCjWYYLJzoP1CE8Zf1a5LT
   VCI6P86rYC2k94p94dyZ+x4/+Ra+msx0u+GS9nsz8cuW/n78mLnWRbC73
   i72JmKOvTBuBnYwBRz7Ypx/UgIBqrF5+Zon+0n1Pm/qCKfwH93Y/RRmAR
   Wlq4r0dc5M7vRD1kv0ocKx74B78ednYZymBmU0LajHI7YRwVVnzdyHSRj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308202401"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308202401"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 14:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="608531854"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="608531854"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 21 Oct 2022 14:17:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:17:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 14:17:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 14:17:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 14:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP5VABMIWPZBh4wIwW88Z6mvr2rKUKeFK6MDs7DCLyJU7LOh1ZTUf0gKHMzSaKPijboDTD8CiyVRANhqerD9+bgKw8xXqFXT6XpJCuUWLEaAeM7kKLncPWkw5PRpM1P/nn9BmiGfBiQ8o1/7qeug74PBpNnPkFiTWjeLcx04r3655PCB/CDiXCEAv9VM7vfsiY0ZpUTyBmphYI+XGZV2S/eviOW+i4n4ivb5wAoA+SJInyOP2iMquf6YSZzANkWK1YhVQyCMJtdfafirKF/C+7Dx8U+7hdg3qF7ZcZy0PTB0oTB9lq6FzEJDDQcX/3wNqggMXX9x5nrEhanzYzweNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R27GcZwIjW8zWeCwklvpTNZDqKAzJTGFSDvwJX3o5Ls=;
 b=VjcvJTN6Vsd+PV074jNoltiiX7wbDhwXifdXZWZ5nmjIfYy+VGkFwC64BMHlecXeZ52FtuMmnmE4KrKiBRUkwL2ieKrkiaJ+koRV5/kFCRZIHTATso9nA64x4ROjw1cMXy766K3p8yjIeBG6EyobE18rrsqOxVCyMs+BKG3xcVxafdwRK+j+NsDkOWnwLWHKWW5hPooK+8lidscdnkP9f5vGZOW/G/8Pc1B88Lr8d+8zuqnOT5EGiGTv2BgmhXHhvSz7LtQR84JMp7BRXvZidWHnqVIq6Uvo+DEjACbmd++yZeDeDGuv5LJKcEUdfcmfd9azTx/O6QQ8Z+vNDNhTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN7PR11MB7509.namprd11.prod.outlook.com
 (2603:10b6:806:346::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 21:17:14 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 21:17:13 +0000
Date:   Fri, 21 Oct 2022 14:17:11 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>
Subject: RE: [PATCH] cxl: check decoder count for end device
Message-ID: <63530c57381ff_4da3294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <166326546707.3348078.8667496731861557941.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166326546707.3348078.8667496731861557941.stgit@djiang5-desk3.ch.intel.com>
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SN7PR11MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: cd493202-9656-4b09-157c-08dab3a99f9c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TW6+YvZnEeYxmhn5V28QX2ZC6uFsBdqMveqcR/ioT5uMZYqWJ3daQ1WA5KENcBapcK3CcAFKYphkUI2+XUlVccpZeiKUnOr6jYljs97LaVv7xsr3mtq4bPFlcTdNu9XOVaRTn5OFM//AfToshoJXl57tIBtGQOdHAv545kJzI9fyqhz5qYairqhe4utoKpw93nZrF7jvgrmH7knZy30VShjRNwDSLnmrIOrp7Ykmqekab5/8w/CeKqTKIXn8dWRR+HpjFl/JZsbOWi4r9SNafOunA97ImxHGzz+4GQPuMEUcszeI54bC8O2BCAXoxYnv30WIBpWfpy/WzWlC0K8DwIbQ58Kk5zvjhlpkMk4YqQPWWsMgrluVIO4UjPkY2FApPiJbLnzhbYD9teBt84gu9XeH1uyDV+ZefepCnbVmCfD0u/qRI6gcKpQ36kzlo9E0T9IA6/9f4etggnh7A49Xr+8qUtq9vG4wQ/y1kGJMNuA1iNqYpQnaLbwp6YDPhWPHZhCV6NZOdAmv/zV6VRE9RECmEZBuyEhL+86GA7InJp5ZiwLihOWF+MWR7A/PEoPWsYuo9sHAjJaPFvAHk0N7Mk6z50Gq8/+QCJ+hFLkTUjQa8+K2ijNCIergBQ2Nt9s4qzeMUx4iVs455eOD9A1LLp+ueDcIAAZMqG+kGqn2A9nW4Pp7ifH7RWVOI+NxYfb2Q38+DQ8ot4ncIcAbZn8lvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(86362001)(82960400001)(38100700002)(83380400001)(5660300002)(107886003)(26005)(9686003)(186003)(2906002)(6506007)(6512007)(66476007)(41300700001)(6486002)(478600001)(66946007)(4326008)(66556008)(8676002)(316002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0c5WtMoDgLtx5Trl/4ihh8u3UMea/4032cTJoVDyyS1D8RirmRNFnJntG7Qr?=
 =?us-ascii?Q?1Ik9aVdDs1btXirlKRo+sww7URUIfwj02Hf6Nq52w7MJR/xS+V8KjEgr1ix3?=
 =?us-ascii?Q?w5oekQTudpjuIKDCd8kNXazmjrFarqoesiGAHXce83LAlFMiHB00czhHNxfq?=
 =?us-ascii?Q?7L/IJBjxgIFDYqYKPE3ddU1gGZ1S1Je+mT8MLpmDqrNk+YXdkiAWwDLse2q7?=
 =?us-ascii?Q?9yQXn8ByWQAbWT+jh2IoqASoVWZel0BBEqtPP43/ssDf0f5DF5lGMID3gxYp?=
 =?us-ascii?Q?5KrANlm9NVVaGVoTD5BwDGSZZodZenmFMRmPYr0YixOxSgg47FS1WCavWP8V?=
 =?us-ascii?Q?W7Siaoi+nLonQxgxCJcTMt9dDr6aqLse5meFKJFjySt2XvttP+L+4A/P+Lzy?=
 =?us-ascii?Q?wuFOJwZd5sA180UWnWYVxr+ryYtHGX1Lho6vl0wmcDmr6m1/G0FcEdaK3SVp?=
 =?us-ascii?Q?vPwU4G3ddYE80Z7xjw2G666fQstOygtIBxwfrZFahRwzLnhhGprPOA8rk53X?=
 =?us-ascii?Q?vbG/w79PqsGsQP1KLQJs5UN3B1Nr3UZNAntTCseG5G6dNZtPte5brRuuehy7?=
 =?us-ascii?Q?agj/3atFJREL2F0sYB75h/E5JsHUygIQ6nFOTJ4LHASRFSO40TBZFWij/6Dk?=
 =?us-ascii?Q?LmUVn98MoS6jF1nE65wLeP7KPs1e/Ke488pzfSiYO7pdWPsyhbFBGzN1/1MW?=
 =?us-ascii?Q?WwFrCH5RtFRKjiCS3hdSPKsAHedJHLQHIhWrbxNgxE7M8GrLzclstXDD1qCB?=
 =?us-ascii?Q?VJB4C6QcY94flQAzxowQoY7gHyHGMhMpJLuZWiuz0DMlSeCNLlTWwJJVEmvF?=
 =?us-ascii?Q?XYJ5I3TEiujXiph2f4gDmrEZ7EqeOE5k+0WSW45jxrxN54oB9pqQEp6UK2A9?=
 =?us-ascii?Q?giN84YaTrdZm6ph6bhv/aEYJMUupIh9xe3Sb77GHrPvLBNrcThzWFc/oIMdL?=
 =?us-ascii?Q?Abt+YxyHzIFy3BJ6H0KpVqhp2x7pvC2dPNtwAvrGZaCm4LPxjchkyj2A32jL?=
 =?us-ascii?Q?0X1pODIKkfM97LsQQHqlZfOTkATn87ik/MBA357CvlFdSowX8WmrnNLVF/W5?=
 =?us-ascii?Q?c+ptDc40ZJURt6q66hYMoRejnO9koDS7ldeUccHiss6pvkyutY/2HXcx5Mtb?=
 =?us-ascii?Q?bMdiyB8Q++8eJGuHHtHm8fK0YDO18BqL18QTNEkzgdXPEFv78lFDaavdOspy?=
 =?us-ascii?Q?e2mUijYmmQrhMqZ8gmvzZF/+g3qJxHV7lQHVYMgqfAtCbO2hfpJMyyCNQYVr?=
 =?us-ascii?Q?HOH+rMvbUHjZZbRu347ojXBzVD0rMCyTl04FTpvaNebL/CZXvhpwYKDhPuDB?=
 =?us-ascii?Q?uppjo6slqplql6FXj4LaeV5LoVBj4F6l7ebhQb8z/htDs3sU2LsxGFs7No+y?=
 =?us-ascii?Q?qpQZnf6nAbDCvQSSREH2Ue4HOcb9nmpuOhCa+ryPSy/9VO0etZgFlx7zc9Er?=
 =?us-ascii?Q?bBBE6wPNJjZ+RMHSUSila0Rx7jQCVGzaf9iAhnjmC5zs5C/T90QWrY7Uh2So?=
 =?us-ascii?Q?5F4IJMMSMwtg3bWyhIDzHyBM6MU7nShbGpQCIZLsfVhkMm0UCCLaHJ+pS5G3?=
 =?us-ascii?Q?rE86bcobePE51N0UTaAxaGOOdSgd30hxN9bE1LQ26F0qnC73U9b5uegG0Ylc?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd493202-9656-4b09-157c-08dab3a99f9c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 21:17:13.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hknkz0a7IinH+WOIE4W9ZsHKCO0fiU7p4M4omgGbwAYLy5d+iWvFECasIT4VZ3rqLr8bdCzaFMo3VrLq+DLlevucyBkeHUqXovkKgNFTins=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7509
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
> indicates that for devices, only 10 decoders should be advertised. Add
> check on number of decoders greater than 10 for devices and reset to 10 to
> force spec compliance.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..1919d99d157e 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -71,9 +71,23 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
>  static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  {
>  	u32 hdm_cap;
> +	int decoder_count;
> +	struct device *dev = &cxlhdm->port->dev;
>  
>  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> -	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +	decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +	/*
> +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
> +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
> +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
> +	 * found.
> +	 */
> +	if (is_cxl_endpoint(cxlhdm->port) && decoder_count > 10) {
> +		dev_warn(dev, "Reset decoders count (%d) to 10, spec violation!\n",
> +			 decoder_count);
> +		decoder_count = 10;

I agree with the reporting, but not the limitation. The Robustness
Principle says if allowing it does no harm, then let it through.
