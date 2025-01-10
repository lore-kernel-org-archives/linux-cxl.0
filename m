Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CD2135AA;
	Fri, 10 Jan 2025 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533661; cv=fail; b=lAgfbhEmj3GsnvX7kmhFChfhNCenz9cNq0cjV/thGuv7GzG46QwQVARkAArrSpXD5OvYM1emlhcid5njCnnOUbKVNpKM2HbtQ9XAbfQH3yX3EacCjIQ7zGAOPGjWvk/8zuc3oDSDKlwbyTBE42B1CZa5c1UHqbVQzanH1clSJwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533661; c=relaxed/simple;
	bh=2/N/cr8M7qTspFajOB5e+WJPucjCxO4V3ysNEOBkx3Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QjkgcEh9u1/qRBEsAriXfqLDhtD3CULsfiL49PmvRNE5c7BNwuEkHTGfwK0rjb2t0rP69szIPCZubmhMntNjxNFl9jKCQOw1B9bTzcoSE1lJCbN4yMCMoL+thAmZLuTIR7qwr2vdjxlgdCPx6+iryJSfPi1f8RJAIhXDXQMZQsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5qtGvwR; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5qtGvwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736533659; x=1768069659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2/N/cr8M7qTspFajOB5e+WJPucjCxO4V3ysNEOBkx3Q=;
  b=O5qtGvwRLLNNYiV7cMJeYd4pxWV7zxCqDBWX/gr0WkWnBQ7HnxHmX20/
   cDM6uOFmMVYS5op1qg/JLOmYlliuIkaBcHCA4n9kd6xxBxUGg++LbyRqj
   xqrmGgOgjarxyDC2aplNcqdWkaqVChUfp+0fPyl6Z5ACn1XwHfWLvtqPo
   iMf7lNNQaBmy6rDL2AnAktDsGZtR3gDnD5PK+ezdgZKQ1sLCK/Ou6MpxV
   FQpeIqD6sxH/gAAzsLar6XMFecU4ZbeVZWmMbtpFQh+s+BzptEng6+LrP
   kyHK13EMQ7tE2I9mb6MpVHvA+P0l9nsYFAtHf5n6tVcJ7HzQ68n/qflwi
   Q==;
X-CSE-ConnectionGUID: aS7ahdfzRd+YkqzsDBwx/Q==
X-CSE-MsgGUID: hBc0vsotRqik46ewKFYDjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40775870"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="40775870"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 10:27:38 -0800
X-CSE-ConnectionGUID: 2Nv43XL9SlqFJ10fiFhM3A==
X-CSE-MsgGUID: HavAiG6pQR6LRi/6aaPX0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103614061"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2025 10:27:38 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 10 Jan 2025 10:27:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 10 Jan 2025 10:27:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 10 Jan 2025 10:27:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgoEWz0LKVTTeyX7t+NzYoiwC2dUH8XkCiiSdaJF/NyySAD66T5W5gFq1FztbufxmjtQiYoQXj8nRSV2GP98Agss8x7gFqFGdJMXiTOc8wMSAIOnJsCIdPWG3rv55LkBG8eUqZycEsdMjepGQ82Ucxj35YopGihwxfAHqLeQjyi0y08wTGPpxlnoe4t99hE0lGWXLxqX6HjUmqT9QTKdgszUjkq92tDL9hN96t8nsVwj5tILRv8UAPINmKIHmYtslvGuiiJ1e9AaA84qC/zq/yiPV0OLW6zrRBmaYnE1e4nh7aiugK1jYHPxU749/vgqSqm8nJe8TWs20NuQKbuSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsQRHixUGHu2cb32jzs/rUv3xMZNhWN82aVnyEnj/rg=;
 b=NnmWm1uh5JbC2v0W1YsRZmy0qp/enCEG7L2Nl47z45o1HGqEylZ4ywdyGT9VhiiiH6HypNolcDG1+WIRIybjjx5S1w7OA4qvevpauVoPzU04tJg+lFUYRyBrioYuS2CBbsZjN1LJF1d6rf2CFFwMgYuPNTKQF7vZ3/sWdQp3ftW7/lVVy/AYxMjHnAexepu1fgW8bYsN7C9PES4JQJgyPOa6jJ2sbKn0sUCQqdDVMo7IdIdgx/YypUtKUMaazUfeRwvkKtNE15UJTngeWL2CYkShWFU0/qUUOrsmRwG9eRH0rlvT4OB/vLLgnqumNQnKXQxdtqSUS/yfz6DTeY0z1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 18:27:35 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 18:27:35 +0000
Date: Fri, 10 Jan 2025 12:27:28 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <shiju.jose@huawei.com>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <nifan.cxl@gmail.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: Re: [PATCH v5 4/6] cxl/events: Update DRAM Event Record to CXL spec
 rev 3.1
Message-ID: <678166907eb67_17789429416@iweiny-mobl.notmuch>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110115556.1654-5-shiju.jose@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110115556.1654-5-shiju.jose@huawei.com>
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BY1PR11MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b6d867-5525-4822-8d50-08dd31a47405
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qj8zXIfgRECBG0T5NdTlwvCozU7m6HOm3RtRJy5aSrb/GAGgHzg+O2V/TwDV?=
 =?us-ascii?Q?y5sgXPeQqsg7zFpkwkt0Q30Ih35hL5+li7RNdae0N9J6vt2en64u58mxGnnz?=
 =?us-ascii?Q?8nORO6v9eQimBQ5hjE5u1jNzSY/l8iINIZwqX/HdM0Pn/+Cz8weIdKzD8UFb?=
 =?us-ascii?Q?LvdIe1NAag4p4i1CtcxEYbFbDY7uqJesUxk4Ts4+DKq3VohwR2uQe2NTJaUr?=
 =?us-ascii?Q?daPPKdYE2KgtP8uD69oROFbn5CBBE04sobz0RGTnSDaQrz+/Oj+YOofm+Dxz?=
 =?us-ascii?Q?3OZM+14jUj3q/daWftXgsyRQlU5QJrc6uNX+6bahWAvrHAyKo+Qv5Lf0f8IN?=
 =?us-ascii?Q?5hfcZ/sXCo1XQo6oOX68MW3CqTZfOZNrI8pjRzpIuok/M8dW9t8SCJQdNQe4?=
 =?us-ascii?Q?ASzWvi8cY75ovi6Toik43VT9Cr22ms/kjjz1PJ47/9NmSLguBaG8sBHkWp+p?=
 =?us-ascii?Q?9tM4TVqS4HLMy3lOjoLrqGg1G3YvxIZQgiv6YVt+4Dho8Vh/x5CUryAdWYo+?=
 =?us-ascii?Q?6s3+OhfngMrGdOcUb+ddo/1PbZTy0kqbt/jEEAkKCI5iYmCuj4m/hreFxwkS?=
 =?us-ascii?Q?5rC7GzDh98yYn25MK4k+CBokCK7QbkNyngBanFDD6XHu7SA+6hpVqGX7rEdl?=
 =?us-ascii?Q?CpjJbZmIV/OpdbnVfkpdO+9TzphTjvaO88fUkFyaSIDe/CkBfCYmfRZpPdAR?=
 =?us-ascii?Q?LgXR1s0D9k03sAllItIG++mMtsurbEVAwzv4lEh/xtr7UStb5wg3ieYf3TkP?=
 =?us-ascii?Q?ONSEOpoAr16+Kc85mPPyJkOxGGjy7rTQxdM9o6CZWUYfxUQZB8sc7OdwzKhf?=
 =?us-ascii?Q?oBB1W/ZSZiedBthJbWXFtsqigPSHvjPBP/ob20zxQm8r7KxKBKCJ+ABnTDMR?=
 =?us-ascii?Q?G7A3NF9RuixgdH8ofTMhOk7JG24NCSAqOYSlLfKNpkAOn12+uVJHZIhnpKc0?=
 =?us-ascii?Q?OB1p3ex0oZm4kezlfNPRjMdZ4jIp+Mo5Xh6gmFihHnXcdrBBFL1xlGsUYuKD?=
 =?us-ascii?Q?EO61zwH1Vsv5ocVFgjx0emyk0SK0UgYUSpJX4oG1z5Icu2Zgid+VD2/4Mdv7?=
 =?us-ascii?Q?L5oM++w5cODUbfdY94t0sWFA4/Iq8Eo/qJROmL35cwoaWFH2LfZAJZv3RFa5?=
 =?us-ascii?Q?Q/PYwsSrdK3tK+FUjcZFs1HC92qkgO3eZ/TwI0wlg3nCb42V8KYFjLtt/6pq?=
 =?us-ascii?Q?9ykoAf57BOOjT+BAxJPjcU+sv+Lu+2C++eKa8Lk6dl7XQaH1SHSbu7mBJCPY?=
 =?us-ascii?Q?F9MeOCxe3p17oEHpJgITHrKROBbLBi+yQo+Dswc2PRtQWfNI//qyYtCyRRhe?=
 =?us-ascii?Q?T2DUQocS23KCQBZZYE7uYnu72WtyBOH55d0dPjCGVWGJJOgK1qP9VMi38J8r?=
 =?us-ascii?Q?SveYKrVN+CZvkfEAfC5ogaXLmWm+H+cWjleYS1s5BOiXkEQG0mrtwVECzNTY?=
 =?us-ascii?Q?xSclPYqcnkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yh6iN6ui/AHGtXBmze+WizxJcYACtbeAW9Qk7bJTSAFrIpLroxz1ZZLbp/vV?=
 =?us-ascii?Q?o3Z9zLAocBh3by7Flst9r3mHxjrAv/QVaDQs6MKUC/cO+SGWVqeJm6XuWCrJ?=
 =?us-ascii?Q?+w2qSJigzdNHfJEidmaO+1VLhgA07cMp8MGrbFWFArV3QwA6K50fEmHs7S/D?=
 =?us-ascii?Q?cwTcO1wDTpk4LECkXZSN6cOGYCmru2bj5DytF+G2rZ4QJysmscz9ZJtuu7dJ?=
 =?us-ascii?Q?8OAA1iS9tVLW/V2hybnND4IaW2nEINBvlkeZlZHKKrEfA6rIJN/BalG5yjSA?=
 =?us-ascii?Q?KAmdicKf2Fwfu/ATTYpnhRI5IjPmN04f8EOdksMj7S/ysW1LHpVKT466RfmN?=
 =?us-ascii?Q?K/cZXG0NmEXA97qPOx+fQhdi6AhQB3epADnRIe6l1jy/zKxF4ACAeqQQZ6I/?=
 =?us-ascii?Q?Wx1++PO7zNdhjEiwKd1bFT6KChIgM/7BtJzoe3IloF4Yw6nw8KgAWrvQUFkB?=
 =?us-ascii?Q?rChqL4qJRI28ap3gayiDV8rrye9XGZp+LEksybiHUv7vNWAIJqRwePbxODjY?=
 =?us-ascii?Q?OJU0krLLGnOZSUaBcBB80L+497XrJzdlQSceJoTQO4etqKY7xeDICrzj5gqu?=
 =?us-ascii?Q?ggRbEacSPuXuoPkqafAfoRggYLOYZLjfmwV8JOg167XLIcrUiA2f87Eelx6H?=
 =?us-ascii?Q?jDP7KUOkW+8Te57ssTx1ig0f/JbnpGb99PhwSGjK18jrNI1P3BaAusiGqlxj?=
 =?us-ascii?Q?HNHaEce7LEaGsXz89wv6vHrDorlnONt1T2/2vTAZhqy20XdvPVy0SgmalOMl?=
 =?us-ascii?Q?Ldmrw+IbAWCgoQdJrVEairXUCJFgXUEhSuM3/ci0FmRM0uZ6CQXttW7PPQEg?=
 =?us-ascii?Q?a3SX7xlwrZ8ERHbHmnP6PBHxugwDnj8ygyT8NQ15I7R2Xard3Gxx9vl2cLWl?=
 =?us-ascii?Q?w5onDsPFbqdocglQpapiRiHlU38wjY+SdabdoOwGAHTkLRNsAuL8X3pxZU9H?=
 =?us-ascii?Q?KqstryG3XFm1Ynniax53dVUWt1jCym0B5N44dC+hNdZ0EqumW+r9vKzH5QRw?=
 =?us-ascii?Q?REc9O2aVvpDi8wkgzCuXvyDp5Zte24/C31yk/mAcqDzFKswALnK7DnfItW5G?=
 =?us-ascii?Q?Ur3CL+ke0S3sj1zTPemW0GWtDox+/hRxEaBir4tx78KW0yeaPinyZ+hI9ANw?=
 =?us-ascii?Q?iTu+dhD1ElErT4WDHWns/5zOR4cma+2dSnWXVPo7c6COsCAPO736/+rkuIHX?=
 =?us-ascii?Q?AeRvOLi4zRFxvyZpJ1136loMays9jWiNzHVICB12f4VHLN2MiwSsRcvpyrC4?=
 =?us-ascii?Q?sz9CDayacsR2kEJlZQjOe3caPnpvu4XE3eS72x54TZp/mSo2jaCTzOV3jx4Q?=
 =?us-ascii?Q?YYtQqPM8dZT/bvgXQKm3z7pbp4o03CLNNcQbMu6AC+a3N/qOufUz7MZN6lXs?=
 =?us-ascii?Q?L8jdvfCYZJ4KQan7UTB+bH43fL8E3jKEasQP+N5rVGORi2/h+BWAipgkRtYA?=
 =?us-ascii?Q?m0Aw6/hp43Tb+acU+t3rTbjxSuU3kaozvs2THrFT8iX9VK9jAIAeJTTqsQr4?=
 =?us-ascii?Q?e2NCsDeVzRtvzqU6/jCPhi82kMojxv0ppteM5MtXPU99052pijKaq+LcrvU5?=
 =?us-ascii?Q?g+0b7Eo4iBFVqcGVg9j2md/2o5hQCed7X/GrbpyZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b6d867-5525-4822-8d50-08dd31a47405
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 18:27:34.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+61G6HRXuNmEnDCdW2LRuNPM1PUQteGu66diQCy+S2/WiikIjIdePdwIcNZw4Tm6VYrfRNSE74XjS+qpTo70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com

shiju.jose@ wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 

[snip]

>  
>  TRACE_EVENT(cxl_dram,
> @@ -527,6 +539,7 @@ TRACE_EVENT(cxl_dram,
>  		__field(u64, dpa)
>  		__field(u8, descriptor)
>  		__field(u8, type)
> +		__field(u8, sub_type)

I just noticed this with the previous patch too.  To pack the record this
should be below...

>  		__field(u8, transaction_type)
>  		__field(u8, channel)
>  		__field(u16, validity_flags)
> @@ -541,6 +554,10 @@ TRACE_EVENT(cxl_dram,
>  		__field(u8, bank)	/* Out of order to pack trace record */
>  		__field(u8, dpa_flags)	/* Out of order to pack trace record */

Here.

>  		__string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
> +		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
> +		__field(u8, sub_channel)
> +		__field(u8, cme_threshold_ev_flags)
> +		__field(u32, cvme_count)
>  	),

And these reordered too.  Like this:

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index cbaf6244d77f..6f4bf4925cbf 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -539,7 +539,6 @@ TRACE_EVENT(cxl_dram,
                __field(u64, dpa)
                __field(u8, descriptor)
                __field(u8, type)
-               __field(u8, sub_type)
                __field(u8, transaction_type)
                __field(u8, channel)
                __field(u16, validity_flags)
@@ -553,11 +552,13 @@ TRACE_EVENT(cxl_dram,
                __field(u8, bank_group) /* Out of order to pack trace record */
                __field(u8, bank)       /* Out of order to pack trace record */
                __field(u8, dpa_flags)  /* Out of order to pack trace record */
-               __string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
+               /* The following are out of order to pack the trace record */
                __array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+               __field(u32, cvme_count)
+               __field(u8, sub_type)
                __field(u8, sub_channel)
                __field(u8, cme_threshold_ev_flags)
-               __field(u32, cvme_count)
+               __string(region_name, cxlr ? dev_name(&cxlr->dev) : "")
        ),
 
        TP_fast_assign(



Other than that it looks good.  Perhaps Dave can just squash this hunk?

Ira

[snip]
