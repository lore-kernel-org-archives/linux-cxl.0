Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253B2D605
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+O+Y8pu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704411431; x=1735947431;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uTYkG8g/2uGsc+dTbFXQ7v0aBBaU4n54+6XB6eCHgqI=;
  b=M+O+Y8puth5MraSymkcfBkj+YgPuPblWWlXvr2s1KxRzWGEvTu2U8YtO
   UZXj5oHcZCKWLVOjmZMk6nwog78kOK006H00SR2HaP83cRDfL/icXS78Y
   sAV2QPQBwbotOujP2FeppgaApwBIUOy5HG3bqWcs3obE3FUp8nudOunla
   wYUHBm9NwidqyExEbmWurV+CR42rGYISoAwWHwoqcBq/CVCLMouNUSLGX
   fIndY1kL8CdVEQjEpdisvSNodOK3zfYKvmldiWgj0YLlllx15NfyKmKDT
   2otqTv+eelhZc2ja4J2HXxFFXcvQXWvQLS4mVuGIfERpucyOeV2A/zngO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4753909"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="4753909"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:37:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="15077130"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 15:37:10 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 15:37:09 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 15:37:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 15:37:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 15:36:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru9hTEQtpq8psEMaRsp3KOdcWqtiK9HW7NVlBxuQLG4ARSkMtT0sglmaA+Ebi1xQHYOeH11Xx+EEQhh8yRksjip03CLp8t6MyI/dwux+EDKxPDBxSEN6M1z0dv66J6gtfN07HB52HrqC9r11yt2ZVEjrbUGAWaGcVT/dFJIcLlujWbL9e/rdRF8ryjbdxfCVmrPI0g0n5R/AVNTP3MvKJEYXdHlhnz+XEwQ4e1TFz4GS7wbpVfvelJ1/DYX5uhMVU/y1mcUz5hisExI+uYTNUbZhE4qwO3f8xl9VB/9HLOU2SUCKo3ALfJ2QXcC5avrh3OBuD9oWPYzfCWMD+0Srjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCiIbbRF2nzxb00bEP4umXn9xmXLARrsQN0jKIS56ho=;
 b=FyEYA9cv6WKCZ5PLtMNWB5gqMcs+Ts6ZslQvxshtwNnqGOKSfk4bgVXNfsjsmlM7uOnB2d9DdIPojLnHY2IyGk1Q+EQ0Qp7OAxl3jOuMidFzMVz0U0kW6WpMQ+IW6V7JxzRzIakdcUrcRCJ3DFIyk7M04sqCvmc0rVaKHBG/hO3YF4RE5N9zJIw75WVpKT77BhLNnLy67yQWiN+Jrz6cJpz1ZW1Jg4THhgNYiDa07aPHoBNeg506ciMcplYDi8eeQ1+UJDUKupA6CdpZQS8Dzu7xrc6jgmthn/uDIe0wE5/ncrZciop0OvZma/boE6ib3SkfP+S/+dvIKiJPEO6H+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7825.namprd11.prod.outlook.com (2603:10b6:930:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 23:36:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 23:36:45 +0000
Date: Thu, 4 Jan 2024 15:36:43 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <rrichter@amd.com>
Subject: RE: [PATCH v3 2/4] cxl: Add missing device dereference after
 find_cxl_root()
Message-ID: <6597410b4336f_8dc68294b1@dwillia2-xfh.jf.intel.com.notmuch>
References: <170440924347.3570725.6271367271629367301.stgit@djiang5-mobl3>
 <170440924930.3570725.10428771109298188521.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170440924930.3570725.10428771109298188521.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0086.namprd04.prod.outlook.com
 (2603:10b6:303:6b::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a27558-ec3a-4e45-6101-08dc0d7e0389
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+6ldFPKL2P6P/P9OQkvTcDRnlwhojZNtYvfS/23jMCI2FPx+eQAh918a00Pfjac6U/seesPikVE/Eg/lkRbpYr+A1hF4+cmMkIImnC2WkzuEynbKYwQvI/p+4szthygLELA+OuiMA0uCC3VsS1Oijwc+wP8bu1a5vf99iSJWyN5jZlH4AMTHdOln0sU24CsB4PLJ+r7UAsSP2ezChsFQXnJU/U0IahK3SsTAB8lFh7GpSA6LfnFFk2sIVAXk8ywXGZVEaJ0kHeMWURJw8F7ER61MWqi55P7nsHm+PdE8bllNxcrZPelJ9vft2omJdnqtEqUgbl5cdDmOQr0dHHZQeBypPZgIK4b0gyLPC66tHyBUO8hfTswMskypg1pdMngaLqrGDnQ/dc6tIMauqtmCmQQ20vS62bN4Kn58AS3TKk1uIGpmDTcyZnRZB1zEPcgPNU5jYaPzmpvxIFFwLyOtaZDbDNVbAvClVvbw0ZAf02j16k0Zg6fUYQVPmykEVR8qNmyAdvGKGYOnOTHAEqEOm8maddEIs3Kl2mWYAgzE9v3CEuCzNrtNEOafCXjdZ1W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2906002)(5660300002)(8936002)(4326008)(8676002)(316002)(9686003)(66556008)(6512007)(66476007)(66946007)(26005)(83380400001)(38100700002)(41300700001)(82960400001)(86362001)(6506007)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3eDdGAkGWXqz7/VDIcvba1SK19cV9mL/PWNQQVTi0pyPqrkSVNgz2rcFRb1+?=
 =?us-ascii?Q?pUfjwYrBL4zavXnuqS2zPLu/SLnNdBveNdxSu6p5sQ7N8mrNr77y48U+RtOO?=
 =?us-ascii?Q?EK67Hf+gUZulHTXFyFmOCqXCVJx5xRRk86LJSkaWHK8PrCVtnZjFnDY+tw/n?=
 =?us-ascii?Q?O+fX1OHMMisKMFM7dnkZsUmJmZrrHSES6g7vD3KoBK1qM+tkqEy5MVuBGofL?=
 =?us-ascii?Q?J4C9QotF1rEUmq/7Tf4TULBVzjLhlCfCDLxKMvf2a4f13RreLtQdV3DpoiN7?=
 =?us-ascii?Q?WAzAwjtuCdyYNFeI1DglEdYSxCfaSHRbPDlpcYSoL4/8q6+QhopsOPmSdyjb?=
 =?us-ascii?Q?ulgPU2OHFdH79qvTdV7OkH7HPBqm9lFrHEqbJZWnAOHKgz//c4YahrzMhGiz?=
 =?us-ascii?Q?ScXSfFULQBffjh9bYcwE0psdwNHt++Q8DxWsmXmMC7wPqaAz6gpb423XMS14?=
 =?us-ascii?Q?4nT+FgMmRgnXvUIXdEyHUSo6dLX1NtGOwY1IwPZXEuovQSi8SyEC+8fogFON?=
 =?us-ascii?Q?LWX05i+0kxNA9oGD+uxk6VRH63G8hazXHew25ilTxWvFDqzaSoFTMS/Bv2MR?=
 =?us-ascii?Q?8Mb+jFZ/iWvEjLe73eoHo0/kO5MbA3VSruNSwZI+9+C3WWRc3k/A+Ec8r/T9?=
 =?us-ascii?Q?zuasriCcH/FnADDeKFAljRFmaM2qNLJyB7tf+PO59Je7GQSytwWh5D8iuiCK?=
 =?us-ascii?Q?ZDhdRBYpFSWUbLWgpxxNLbr1I/CuaoZFgK0oFusknXWaM4Cj3nqMtiAt7xwV?=
 =?us-ascii?Q?W1mMFLk9F2Yjkhm3SlCnLqAfpxHrZZ3mAua+GV1O6MEw+jef6Bq0xFeGMiJ+?=
 =?us-ascii?Q?XkZls5K7kB+420KN3OmvFQmRcovnD8ucvsZ316G/MWwQsmmUUaJBx7p6G6HA?=
 =?us-ascii?Q?6UpK6uQFxtIRK8P+mg5rsVG5SKTEzhz8i+OU5yi8jCD5SPRlQLgEJzl4KR7z?=
 =?us-ascii?Q?XwDpkDWpO3EIgLIkpMtrl8cabrB30GQXpJyt/jXjm2/oZsz9I6bjCcz5JkZj?=
 =?us-ascii?Q?sbbq0GqNhLHmhSij7PiKKcEv2fGRiF5moJGSBXiJUw7gzHSLdoWkQdIeao2X?=
 =?us-ascii?Q?hbu92NC5U7LUX7kFwwZEPKCyEWb8VOm2/8M+NSPU+qCsBfCOrUP5NfYEa7kB?=
 =?us-ascii?Q?jDq0aRhLrX6PrxMa8+s7tY9Uh2sHmw5OMdaGq9slwLTCTmLyajOr+bUVI/T3?=
 =?us-ascii?Q?oBRc9Gx1O8vgEPTswyDweM8hZRTDfQqGtVAadYzkh2x9vWzrqWdw+fWPCzbh?=
 =?us-ascii?Q?PaSpW1hNOKl8TI8yXgLDF/jsQvtpBxKTtCHfIXhoem0qggwJjHVMSqWMM1hO?=
 =?us-ascii?Q?D0VpF6aJJlyv4GaxG4Na3EVflCB3bETnvB4OjJ3KY/7dEiFAHfDh8X6DBRUm?=
 =?us-ascii?Q?hxmjcqQy+ug0YK+b99O5SuN2hLnTwtumOFYn+y0Xeg0NNDz4/FFQ0WpI4+7N?=
 =?us-ascii?Q?DhiUCKR4fOOX8YSi6CHWOE4T3W1F936Tj9ojamIb4rrnIrjhDr23fgkY5AQk?=
 =?us-ascii?Q?544RZ2872CZzRMIRZ4eTF7cPT/eU6yiocgmc8mpZlSfiLBksO5eUyrb3xYvV?=
 =?us-ascii?Q?VUCDCO2OZ6f0v54Aj2LtNLkHPVDbYfRTWGKZjwQ1lBgAXDlTTJrN+q0BtD/c?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a27558-ec3a-4e45-6101-08dc0d7e0389
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 23:36:45.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YD+c4P/6xsMKjbDL9cozkhpV1Z4+sBoQplch/N5zhACa8W0kFjzCLRVWMd+ysSY/9S+wXJZtB5omF0OXevFZqafPe/Q4kjNz8ay3ISnTGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7825
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> find_cxl_root() takes a reference on the 'struct device' before returning.
> A put_device() is needed when once the root port is no longer needed.
> cxl_port_perf_data_calculate() fails to dereference device. Add a __free()
> call to make sure the device reference is decremented when done.
> 
> Fixes: 7a4f148dd8d5 ("cxl: Compute the entire CXL path latency and bandwidth data")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Declare root_port at the allocation point.
> ---
>  drivers/cxl/core/cdat.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 3dce4a201ddd..c5031e90bb96 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -162,7 +162,6 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  					struct xarray *dsmas_xa)
>  {
>  	struct access_coordinate c;
> -	struct cxl_port *root_port;
>  	struct cxl_root *cxl_root;
>  	struct dsmas_entry *dent;
>  	int valid_entries = 0;
> @@ -175,7 +174,8 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  		return rc;
>  	}
>  
> -	root_port = find_cxl_root(port);
> +	struct cxl_port *root_port __free(put_device) = find_cxl_root(port);

So I would rather not introduce this type safety issue while fixing the
reference count issue(s). Given that 7a4f148dd8d5 is not even in
mainline yet there are no concerns about needing to have the abosolute
minimal fix go in before the type-safety of find_cxl_root() is fixed up.

In fact the find_cxl_root() data-type rework makes the other fixes
easier to land.

So I would like to see a patch series in this order to avoid having to
edit the same line multiple times in the same series:

1/ Introduce a __free(put_cxl_root) definition
2/ convert find_cxl_root() to return a 'struct cxl_root *'
3...N/ convert individual find_cxl_root() instances to
__free(put_cxl_root) = find_cxl_root(...)

This patch order avoids broken / short-lived introductions of
__free(put_device) to the code.

The separation of the find_cxl_root() changes to use
__free(put_cxl_root) into multiple patches makes it clear which are
fixes, like cxl_port_perf_data_calculate(), and which are cleanups, like
cxl_endpoint_port_probe(). It also helps with bisection if there is a
subtle bug in one of the conversions.
