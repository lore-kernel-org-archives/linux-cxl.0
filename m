Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7A1D699
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxItVtJ/"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9219D
	for <linux-cxl@vger.kernel.org>; Mon, 23 Oct 2023 13:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698094491; x=1729630491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WrtS78ZGg8E/v2egH0IquqiKbOiMrs1EECll56Hskvc=;
  b=FxItVtJ/NXVYkgA7ct93OWidUrpemYF2Lo0hg6G9KkrdJnE3EKNOcjC/
   pFf/eowUwec9Kw10f2cdM4GLilziYnf+d7jOb9ydBkbCnguSN/H/1ZwOs
   j953Y6tXnryIGkMJgoLOTUJOYAFs07Aqp5AMSu+XnmiuDrNDN6JLCFsSe
   mSJNEueweLJthhZ0fl8pL9zRLURCWs9QSLlseMCmyAkEbbWwcX9PoS/BJ
   pC/ZglWgIibTKf9ylaz6Ib4JrbAAuGmtxljG07r5lCCQ1lPAYg+i56qHh
   I7bFL2DcciJU8zBG5yX3xo3xb0Vet5AlGZt91UhHLzUfd5GcXGeFSmFlc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="377304322"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="377304322"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793257742"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793257742"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 13:54:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 13:54:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 13:54:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 13:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI97v1Ks3tvJc0vrjkve0Ao9Y88CiWjh12urk6yMRXiTw7Og7qtjJ4Xr+KF9/h7/BJ2m6B2+MzSc4tdVIqbXyI8F0liW36twqKHl+fvXHXNQhphfhACgJyuyugf5q1GSOKx0CZ3zawG7j9hftugUD2LafpAxGk+w+Ojj9hQBk8n8j9pzm+90W/XjpkjEduGX/56CDzs2YU0TvkvxBLzzQ0aPDzPlHpDGEU38coKvJ9rM6vq21BQq0+wQ531oFnDcWcH28VhQcscErJkvx+DL5UPktVmT8ZG/G3CyZTiBghuANIkFFuxM//Pcsk2FjOn1L8AoluQucCibX4fz1FqWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Way745IRS6tYS4EKeDSFimuJORMdy+34ZibNUT4IHU0=;
 b=CaXt1l5NtUf+3f/vvBhoxCbs0bB4itJd6AzDTZfpTYVBvjIkQT5CToPb1pQpTeikhi33D/PtEPOe+mUuhEmNjsTaJvmjVAVbsjTjJO3zvkfVfhZXL6kfsj9EqCMqfilLkYNZ00dTP28XCB6u0+mmN3baLrfiMCgwJFw8+L9swisgDEtRoOu8y5k8J7j6dX/5zNxno/RkC4qokKw5x3xcKGW4Jj1+kdw9ItXyxY3SLc7KZZDwri1jSWtTEY94hu2imFWzV/5tu2LGOBhQG490z1LxLA9V+i0WQVus03sWP2a3mXhhbdQN2vPPgdP20uuS5FhyvaH091x/kUj3i89JUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 20:54:29 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::8dbc:889d:7f9a:e7a5]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::8dbc:889d:7f9a:e7a5%5]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 20:54:29 +0000
Date: Mon, 23 Oct 2023 13:54:26 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 1/3] cxl/region: Prepare the decoder match range
 helper for reuse
Message-ID: <6536dd82d3b6d_725832949a@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1697433770.git.alison.schofield@intel.com>
 <8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8dd4210f464e971a7989c7c923747cf2e10409ef.1697433770.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ab7827-bdbe-45e0-6b2d-08dbd40a4004
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M197mPc/+fF2+v3/nP8TdreVKtl9ytTSpxDpF980+GB2W9ru//+tJEZUEoSyow/Xvo9rjctRZKlqUboLNME08gyXZEH3GpFyey6GF7/l7XAr3CmNqAh8EmbOs2KaSi/zino9QXQUPKORvbMSyx1S4+rZ9kNL0rdkxIGZbS0x6yEOumcPWKwLBF3nFyQnjMCdr79ZY8ZsYY5/5UsRKtFCTCy1L4tscFMHTwEWBFgIygBE0sI2DcvELXpHV9iOfr3Cd5Z3uvPAy/nnAhLscDZufYxfVNPW3vuTfFP+yl5S2RJLcCoqEOQfqy0LrL6Abk7e1gp0WeTirqfcKtq0OxQ3H3ObT27rzvatWkm3mrKbTC27VXYp+JOwnS1n++ukfFLI6aXyzLfYKUz0Hf4eUFCdAw7mRkdwOaYC2NhwdCpT6JZr2k8ES03KvGwu5lKbWdZ54F3bhGNPColHMaKSvWcr/vPx7tIMqM4Djhb4d6JHWZGLOeWquoYiSMnXVtF0CQr3Mjly9QCghqTmXTtTUuyNgawLUVCCJ4WcFaK17NDQ/IL8U1nrPlDE+vUGQRCNFgVz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(366004)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6506007)(5660300002)(41300700001)(6666004)(2906002)(38100700002)(86362001)(82960400001)(9686003)(6512007)(83380400001)(478600001)(26005)(6486002)(4326008)(316002)(54906003)(66476007)(66556008)(66946007)(8936002)(8676002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GVVCr7n+95Yrqqd+NBs/fy9fyq+lVkb3ou9NRwJszNHVX/gKAdjAxH4vEKE?=
 =?us-ascii?Q?RumZDH6AFyEP18zRsf3ZblCVL2JJz/hfQR6N48mbbt+ysf7G+wOewQ5RNP1A?=
 =?us-ascii?Q?HEAK6JTiotKWIpoh4Gc9cLLauosc6+fTpzDYmAYkCNggEuksM+jorwvmEIMd?=
 =?us-ascii?Q?jZzZ9XGafbA8oG11zfZ9oGiJeZCaqxbK9NA1g9kc8VGTAwtISbil4KLAdxeK?=
 =?us-ascii?Q?GaJn3LQDt7V1bRtgUl/vhs03zhSi5LLp/2g0vhwodu1+bgDQUbcUHwLcMi6o?=
 =?us-ascii?Q?TCiLBLqrkMt5yElkBr/Y2PVcOW4i5/1GnK0FLt0rMAp7GxyVb5M5B3Ky+J1z?=
 =?us-ascii?Q?gn3AwLcpz/iDUPXfMlHpfOA5sOC04TnAYpNyHv41mTeKo8YNHISWKnJVwdXi?=
 =?us-ascii?Q?w06oqXNPx6jlpU/xoQsopWKdLoE/NbiSFZJqmKze4qB2Gk56S/F7TCS0pW1A?=
 =?us-ascii?Q?W6sEUopWRYAfwuWAzxep/jElZ4zXSIJv6ZjHt9mkr28V477cU5uDfxvN4G32?=
 =?us-ascii?Q?vZhjQRirJJDGHvxsfAFoZHa96x9S+ubJcNPyvEPTvtt972P7PaAnnEsNi3/Z?=
 =?us-ascii?Q?gQ4IJLQ3rech/SyyCMOM50tykxjeEmyvMsMd9H2bA/A5JccOS+1eqBFTjY/r?=
 =?us-ascii?Q?A7alxIkDAqoMPDznAQObkzMFTnUExvRVaMhWWyV8+Rk/Bglh+oPYgR3yDwpH?=
 =?us-ascii?Q?qHk7DUSwEbd4lAJkhr2Nw4isLCVJNeV1CIT4BEteel3Q8Uq7ILKTNkhizbAJ?=
 =?us-ascii?Q?vDk/2sDT3WwmOrHatP9dwBTlrc1hpaMbUnEU/ZNdbwOInQYysxzZYKvqXYUo?=
 =?us-ascii?Q?DCbCuky7nPbFbO+DPbLfO0lTRLhOHHO5HFz9TxunltExMM4pf/LwvGZqnqkq?=
 =?us-ascii?Q?RHm9Fz0A2S5ehwXDy8O6O2IS5N64DpVsz5mSNE46tZZTnCzIgJQrDglrNIVC?=
 =?us-ascii?Q?xzknl7oMhWOD//2dvguy8F4NIO3P67bXgndtc++JuOuQOymvGp5FE3D79Iwu?=
 =?us-ascii?Q?1gVXzY7scWaD6IQLlLHRpYN6aZtHVySXuZdOEyfP0nDRduYwoLF20X4q5y3X?=
 =?us-ascii?Q?man9BGw1ZMy/2FJEkf+vSmuMp3Wjx9EuBub6L/ti8mYLWpiLyMa+Sn/iq1/l?=
 =?us-ascii?Q?UGCPKkV+Q2ReMcSBA5W6KElEa2urHjYfB21sIw/03A7pAJM+AE815jKjEuhq?=
 =?us-ascii?Q?YZHUXqPd7X++4QRpLDKh4zVNt3B6rtNo5mbgyf+44TvCHXhmtkA0eAfo+Sbk?=
 =?us-ascii?Q?BiYPCy5fIkxLF4LIxHJmOTF3OSpN2sqUSOAIHZvLYQKDQB8ho3KGpU2wOdMq?=
 =?us-ascii?Q?iESMFFJx5OX43NQrqMUASa4faOnmiGajxKxHwqpE3c2e9BNrZ1ljSrBcXEUk?=
 =?us-ascii?Q?y7tnvx/e3mtT3+szqDU15JsQ/JGemKWZkwfeFC2D2QUzeiFfe3nbhlwOQdmQ?=
 =?us-ascii?Q?ISqEfwfHOY1I8MzBe4x6C+3iB7Fw1k+/dZKUbWePYwooIz9420/0KLW/HEvn?=
 =?us-ascii?Q?wWPqK9Ep00P5nwuTfOfnhi09tV1xog8PyUi0Bb8WBsEx6Z/AAtbzfWEvn+Re?=
 =?us-ascii?Q?RPNfw3A4ARYu9HMrBeemmt97JWyVChKRmJjIOG1SUrefYqUM7u47I0mzPONU?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ab7827-bdbe-45e0-6b2d-08dbd40a4004
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 20:54:29.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcE+Z4PldUB0I8hT/wEXt67qxdqMU399NZ2MX+fcS9A6ntrrLHEBCZh5iyfk/1sLTOc7B1Kxs8Mo/F1db5wgP+6CPo8eKMmzTfw1+z1c8Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> match_decoder_by_range() and decoder_match_range() both determine
> if an HPA range matches a decoder. The first does it for root
> decoders and the second one operates on switch decoders.
> 
> Tidy these up with clear naming and make the switch helper more
> like the root decoder helper in style and functionality. Make it
> take the actual range, rather than an endpoint decoder from which
> it extracts the range.
> 
> Aside from aesthetics and maintainability, this is in preparation
> for reuse.

Some minor changelog comments:

> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")

Save "Fixes:" for commits that need to be backported to address an
issue. This will be a dependency for backporting patch2, but on its own
it does not fix anything.

> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>

Along the same lines this probably moves to the patch that fixes the
report.

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..64206fc4d99b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1487,16 +1487,19 @@ static struct cxl_port *next_port(struct cxl_port *port)
>  	return port->parent_dport->port;
>  }
>  
> -static int decoder_match_range(struct device *dev, void *data)
> +static int match_switch_decoder_by_range(struct device *dev, void *data)
>  {
> -	struct cxl_endpoint_decoder *cxled = data;
> +	struct range *r1, *r2 = data;
>  	struct cxl_switch_decoder *cxlsd;
>  
>  	if (!is_switch_decoder(dev))
>  		return 0;
>  
>  	cxlsd = to_cxl_switch_decoder(dev);
> -	return range_contains(&cxlsd->cxld.hpa_range, &cxled->cxld.hpa_range);
> +	r1 = &cxlsd->cxld.hpa_range;
> +	return range_contains(r1, r2);

I know this is just maintaining the status quo, but thinking about it a
bit deeper I think range_contains() is only correct for root decoders.
For a given region the root decoder will contain the region, but all the
switch decoders must be a 1:1 mapping. Linux only supports scenarios
where all endpoint decoders map the same HPA range and identify only 1
decoder per-switch port to map that region.

So "range_contains(r1, r2)" becomes "return *r1 == *r2".
