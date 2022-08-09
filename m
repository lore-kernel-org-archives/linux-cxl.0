Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D6C19F2D
	for <linux-cxl@archiver.kernel.org>; Tue,  9 Aug 2022 16:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiHIQVN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbiHIQVJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 Aug 2022 12:21:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAD9E7D
        for <linux-cxl@vger.kernel.org>; Tue,  9 Aug 2022 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660062068; x=1691598068;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=N5yMErzWSxsYlfOtEefMNTEBXxaE6EaMsIc1fbjq/ZU=;
  b=Y2KJyCbaDi4X6i1zUwaCvQKCWeEkuIQWYbfTXfp47w9a9FCfEriF4ZfY
   hnWGrythKSY8AQ7HDfr+SlOq6oDUhsFQb8o+66IOdwNiS/MfKG4JyvRRI
   +blSsyxMnNUZ8uvdMDBRbGQnfoO4OCjkXmJzzXxWLJxJ1vEvhSYOuZWvc
   JnYTfyqSSATrl7RK8LUQ7913yy/wRI7DWkNKor8uSFqAOTQ4oo0UCPNNn
   d0bpH2hWFopP5tOoyPmegwPryq9HwqymMgl1YD6a6IWJGMSNcRnqc577/
   1aiRoMTTcV5q1wZyb2C54lM9beXhhEVG6QUN7rDYGrFp5axGEcpRAdVQP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="271260239"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="271260239"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 09:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="747097901"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2022 09:20:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 09:20:42 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 09:20:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 09:20:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 09:20:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvzCPkVUaO4CuHC4HJzSKBU8+A1IqRa0hAM5coEoI1Hn8WvcWM8VIhjsMM/XgWYIpam3RtiQEVgY562zK9Yujk7v0S+SG2ehKFvFDkFCwagYvcFgs2zE7v0jx20jEIy0JQ7U4M4IVWqCaCyWBiLzGjkmH8YfU7CZ21NOJyP0PV0kaI2z1JMFyKOkbRnkZbkhNKPeiGIsd8e1bK8X527hFzVZK7fav0dfrhxRfGGBmPlrbs4/XyBKwXkL4xSfMEhT32r32zsIU8JQRVCNnx+jvVf/t5eQ1Y7wMRuycjcOYbNQm0Vkxi7ibuqH7FshcN0D7LWLTHwPau/tfBe60jtj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyfQO3CG1WXE5YUUM8HmKjFgEe8nMLD+dtslg6gFjW0=;
 b=XC33Kts8cEEF5VBzhLl/zZAxe2W08lfZKNSeH+0eJX/DeyFoCbg7gJxGjSJY/aKMdP1TEpF/HRbzoIDZdGhAoM9ICSTl9SEjD1CZtOlEWdN6rLX9z84OyIGgrXIpW7ymXPurTjno+T1v1yHHf/P5GEgQ5GGXAGEVShtNpF1KE71GY+WU5r+jMrMeJ1M2f755+Q/RAB5Cb7j3Igiz1sbmQygA7q7Q5ZExn12gDzB85DPNkmg4rL3idwDvH71ATkBspK7b6m8IcB4Y7MPDZQuyx7juB0FSDtki/7JDs0e+KtYXiBQM7S3dIStUqIFVshZaQYDW/sNqZIfjQM1jEgFSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB7080.namprd11.prod.outlook.com
 (2603:10b6:303:21a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 9 Aug
 2022 16:20:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 16:20:40 +0000
Date:   Tue, 9 Aug 2022 09:20:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH 2/3] cxl: Add CXL spec v3.0 interleave support
Message-ID: <62f2895635e69_1f18b29456@dwillia2-xfh.jf.intel.com.notmuch>
References: <165999244272.493131.1975513183227389633.stgit@djiang5-desk4.jf.intel.com>
 <165999282258.493131.2782730417677035484.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165999282258.493131.2782730417677035484.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:303:86::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49c8b014-ec2d-467b-fab7-08da7a2319c4
X-MS-TrafficTypeDiagnostic: MW4PR11MB7080:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyOGDPocD1U9D7b/4IL6peeIylhM/R5u1RhTwnzan1+RVoaWLHvg+jNqhQzA9OXwYTCfH5qIGjv8XTlcZNdGzXUilJ1PWpjATQ6zRYVHFjCE3vJDxzhSLh0mk7aMeGudRogoChJAApEdk9mBng0VEiLlkevpeAWZG8cYE8DKyL2fDpsE2irer0LVSnKWxc3GzJxw78L2F2Bjio4/lT2lKtFByC3IxtfBu/n129pgGa86vf+0EfJFGmsNNVlPaDQwvnPRgK0cn5/MiM8IqSQg2U2gNlcpIATLwXe+CVxg1/Kxil0mj6PiZP9C8bE2YHcxAeUoiHEDweDrG6kkKWdxjgZ/YsZoloUdVAoTLz0WGSvMqVaoNrewYhfbW81VTHg/K9JGDrjo3UbVDp/3xl7XnPiQICoi6Td4/hbswnP2iwub90pET+s9NFyo+m6Xy/mRJR+7MP9eUTziYkcfvLIKym7S7zjHiJGH3ghCTKBZtOEVgBaUv0cPYGNbkPUpo4dA4WzH+KRCy6eT+7gzm/RZdaDhE9FcKBSvyut16xdY4hQ1joK1P7bi42PhA3wpFvLZZI0HUrEz56oD3yZ9WZTi9somw1qmD5NBSoyYtbdy9G9bhDNvI1AYehBAQLA2H5zS78Ig1h/g9HfEcxGwueJndzBDSNty50XG+WwANt+LP8Mp6VujA3d5D+tVynwwUESMvLJcbHrUPsqAEoSqsoTXpABdufzOjrei9IEOvWvrYzm7aEZhGb/14JXcJbNIuwPs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(376002)(39860400002)(9686003)(6512007)(478600001)(6486002)(26005)(316002)(186003)(86362001)(82960400001)(2906002)(41300700001)(38100700002)(6506007)(66946007)(8676002)(66476007)(66556008)(5660300002)(83380400001)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AoEPdAdYnTiae6TmIEn/Dn6uOB7FEUzb6bUfeeCSMye7upEhe+OQVYHoD9oq?=
 =?us-ascii?Q?KXFrAkJg1TVWWjo4o1+ozs1CZMeg7ASlWxLTpJrZoFMQIyoiL7ivzR0LbD3o?=
 =?us-ascii?Q?2fNa+DemeWN6f/xmZrwkVyvfxEyAYZErFBal+ANOi4ZJABfklILUF7oy7Pro?=
 =?us-ascii?Q?OVFN3mezkqrkWwRmMoynOSyNTzhafECiTixG1flbF4ngb2QszJysbKSc1Q7Z?=
 =?us-ascii?Q?GK31Q6KtjjQopfcglj6dT1pUVP2JCsQeUcZGxN/992ZWQFBl7vM3h6+Zax9C?=
 =?us-ascii?Q?W5i5vdOPjTu60rO5aaWPMadcJqbaNdgNv/EKQgzc8kY92yDmCKiivYmMI85t?=
 =?us-ascii?Q?H0Y5WftdpbtWumZgeLVqU+MLl3cdnBFiXsX2aKT1ZVKvyA/+bq0WKAt1s4Zt?=
 =?us-ascii?Q?JHV7G7ZV/Vl9XESS5Eyen/jLrI/fL1335K73sbRPnpwjrcXycf0i0jojt0qi?=
 =?us-ascii?Q?AZ8hSWA2wnn8fwVULzdwtlF13vT6Df2TeFSlBG1vCgrchIhM1P3dqtzfFII+?=
 =?us-ascii?Q?QmRTWLnGuHXbPzMqJy7MhMmSiYdzqvfpq0Dsf4MDBZG8X44kPSvSu1xd/0jR?=
 =?us-ascii?Q?e/9i6Kdjvm9jh4Os7EB/9CHbdONOUgd6B+1fiMlxKLUBSLRTR1tPf16ahInY?=
 =?us-ascii?Q?PYdm7iZPKLxiW9y3ngS2XS4YCgdVBhDA60L0DbduKbyFQ8IdjdNirGYIAhr3?=
 =?us-ascii?Q?BkPciwT8XRRMaPR2vCkVuRRIH+SiwZPBC0hMOHOU533zQB72ofa4dOWGD+fJ?=
 =?us-ascii?Q?55TIYyiOX0A6/bUj4jxKi4hbStANJ5hmsMUISn6Zwgo2ql5qOmryE95BFkby?=
 =?us-ascii?Q?kCTLjMylnMq5dsnQd5YE+VDYTpW2yR4K9xStEuVvhLJ8Bs5yXRJCepXC6+v7?=
 =?us-ascii?Q?iGtW7CowlkyAoT3i3mKLzOWO03phKGclkFJS3nWXCs8ES6LTNjEgK+cjFOqT?=
 =?us-ascii?Q?zeaVjFhLhLm/RBDMQNxrDyX6vHTFJXTR7D5l9RWQ0XYuRhs72xFV273f3afv?=
 =?us-ascii?Q?5G7ZgmXbjyjeqt+XsvVzRzinc/2HmutdvTGxSOWL2WoIfHZLaRDKE0kRjJgp?=
 =?us-ascii?Q?Ju8u2zp7f7yT/ypOJ5d82fmMjukYte5ZoIYo80rsSHktvdY2ry/Id82Zwqzx?=
 =?us-ascii?Q?/PDIBfVEI7IvE3AC3vBhUfuZDxh6OmIZFwNcdlsMbbk6xx8W8XOn49uKK2px?=
 =?us-ascii?Q?Qannb0mqkrCmcUMKxqCr49UY0v+DCkQdSVwF/SN3lNhxfUeqgmhEQMWRLqVU?=
 =?us-ascii?Q?byyy1etvBwpm68BPyY8kYfjSextUgpRTqBk/6eYO2KDF2pV8u3CjcVNvYWQa?=
 =?us-ascii?Q?7+GyoOUdiUMu39Ek88y5eCL1JXFOhnqlZubRdEiQIsw0kpyhGTkBLfW2FxJg?=
 =?us-ascii?Q?PxcZdkX1Vaj3KGmZStxJzyp1yoCNxDCvHNQtZ2GQwbvPP505ZS7/0+NbUHmZ?=
 =?us-ascii?Q?XKgX2hJypa6TB5OXtsRiiP6yp9RhKahy9H7K0h8YkqxXHplZgk94K2m5LU6N?=
 =?us-ascii?Q?7CWH5NwBkjH150b2sZkzeRWV2f0GGc+vTR0gJ05ZwYDkPgYeWr1PlZmJxGyj?=
 =?us-ascii?Q?8I5z8SRn6ckncv8QWmMDJHAVWzrBf4EhH17b3MhAFDxM42ntPsT+Zjat5URe?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c8b014-ec2d-467b-fab7-08da7a2319c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 16:20:40.3161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpN8dWzaIZLniH5orQcc6Blwf+kMyM8qSLJffBqLwdTHM5fg8fYorJUtzHlEMoLPVJaArCAK/maK3Cp9MSfsbBPDxhaccAEkO1RM8Eqifvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL spec v3.0 added 2 CAP bits to the CXL HDM Decoder Capability Register.
> CXL spec v3.0 8.2.4.19.1. Bit 11 indicates that 3, 6, and 12 way interleave
> is capable. Bit 12 indicates that 16 way interleave is capable.
> 
> Add code to parse_hdm_decoder_caps() to cache those new bits. Add check in
> cxl_interleave_verify() call to make sure those CAP bits matches the passed
> in interleave value.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c |    4 ++++
>  drivers/cxl/cxl.h      |    2 ++
>  drivers/cxl/cxlmem.h   |   29 +++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8143e2615957..50ff7387e425 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -80,6 +80,10 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->interleave_3_6_12 = true;
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->interleave_16 = true;
>  }
>  
>  static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 275979fbd15a..db9631d09dd0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index d5f872ca62f9..9b4b23b3b78a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -398,9 +398,35 @@ struct cxl_hdm {
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	bool interleave_3_6_12;
> +	bool interleave_16;
>  	struct cxl_port *port;
>  };
>  
> +static inline bool valid_interleave(struct cxl_hdm *cxlhdm, u8 iw)
> +{
> +	switch (iw) {
> +	case CXL_INTERLEAVE_1_WAY:
> +	case CXL_INTERLEAVE_2_WAY:
> +	case CXL_INTERLEAVE_4_WAY:
> +	case CXL_INTERLEAVE_8_WAY:
> +		return true;
> +	case CXL_INTERLEAVE_16_WAY:
> +		if (!cxlhdm->interleave_16)
> +			return false;
> +		return true;
> +	case CXL_INTERLEAVE_3_WAY:
> +	case CXL_INTERLEAVE_6_WAY:
> +	case CXL_INTERLEAVE_12_WAY:
> +		if (!cxlhdm->interleave_3_6_12)
> +			return false;
> +		return true;
> +	default:
> +	};
> +
> +	return false;

I'd prefer something more compact like

    test_bit(iw, &port->interleave_cap)

...where interleave_cap is just a mask with bits 1,2,3,4,6,8,12,16
optionally set.
