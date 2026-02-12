Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FAE14EC73
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770922717; cv=fail; b=qqY8jv7LhFLJcamDgGTEqJ83It3fq1Tb7pw+WOlqz8ylSYCMvw3iVFWqS9a2JkzugoscErK1twOuG6fThQw8DzRbDrGpiSVBKJG+vJN2b0za7zJLvrO2LHfh2L2Qo1ClqF4jJ7eZGaQ4g/Ob5XBpLYbg8L102+WjJyc43DM3DJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770922717; c=relaxed/simple;
	bh=KehCfUUfQSeBAmGbnCTuSvYI40uLl0stjoM6uNqeivA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RF5ODK1iEYSFOV+MUc3BJu+MGddfHVo40V6ygGDmYgWJjP3nqT4fgn9qNTaiFsdVZ2s6lAygn1lssFJtG0otigEh8Kn7BAARuRV497MirHTHO8vZNl5uO8wUylXSZupyQI36H0D3+ftX+ufiwDa+TT3NVuvclZWk5253FafPdWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V54+zzn9; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V54+zzn9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770922715; x=1802458715;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KehCfUUfQSeBAmGbnCTuSvYI40uLl0stjoM6uNqeivA=;
  b=V54+zzn9a+4jZeQYROkxhXXowLMZY8l866AtwyGKEpAFC5Q06sSNYnCF
   wX3jVjzyl86SnJ8ln2Eo6Bp9jOozxYulAgt/3DiYngVlImLCzPlbRN/3v
   LTRqUz9pdMAUIhWJ1jXNeKBaiOozpEwTxuPFObR0gdLgx/12opw8CNOcC
   gxnAvMfnznpxYQOLfNvZdIijhDABXynyvdovmUAdYirQMtBQyH0o+w6pj
   aGtVfL28xdf8MwAX5hOAB9euJVdsVIps1HDw5pQgcloACfMDGSNYCeVyk
   /x5cqYhjVAbDRDrMauzRf9/SfHL0j9ze2ePvt5y2fpwLQDxfihNVvtXWz
   Q==;
X-CSE-ConnectionGUID: GK+B9ViGSKqZYClwZDeeBQ==
X-CSE-MsgGUID: yBMaPb5CTeiednDRGaGzcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="74705776"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="74705776"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 10:58:34 -0800
X-CSE-ConnectionGUID: Pq9SYuYoRp+V02qV6tWOLg==
X-CSE-MsgGUID: d0tqlA3TQpOGe4wilnNsvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="212165732"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 10:58:34 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 10:58:34 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 10:58:34 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.41)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 10:58:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmY+zF0F2Ey6Axkbxklhs9NdnFBvIP6aIDousw36F8IQF2h3q9GZDqTtmacTvyiJOL6wl0An1MKBsKdUTPA6/R2WQ9yf4hXQ+ET9aYiXdOkkFpilfi1KNlgqdK+KUwOD9eAFKcMN7frtIg6U8Mpwx0Er+aM9tKQlqH0Tsl5eFmOwQ3DcQmLHCpKGALFuGwDr/ZKNBUwlzDjf+RP1oSAdawVeUIAX6fnxGLwNfEbbLRLhhI/DmXMDeKeQtIzoi24CjYemahT2Fkh/DZ5sjTjdK66mkVe6VR3yiumfoIPKqiKdg6DEWQj/BDk0/U+QKUnzrwS7/a5ysmflL1bQ0iHvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHdN4GB1nCD9UT3oC+Mu6iOvQCs6rWumUi41Yf+LWUI=;
 b=m0FU6+ZXccDkdGihqu6anTY7Me56g0a4pwKML5g/CRTqsLEl8zZcKArCnPrDyCyxyvYIJU/Kpr6AY92M5C9y59ebLV8KYp3H+iOmsNRzhYVqxL7lfYMU3wrRqWH4irCJJi+X1XhSV1Xjv2AngAg6vLPuLbDdytmDYifBsXK2UXZ89WJ2bVuqQp/zoWyuBMyRXY8kCMMV4IHZmzrvfnJR0a493B2IujSIeciw5nHysIMUjwmhnBoJU4mYWI8u9yNZpRgGEGSSan9OAeMq8zjhKDtMmf8CA+77G09lC26kKfE42UmGPCyf3M0AD9pxOTDFbB/kuB+UVGcbB681Oa/QOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Thu, 12 Feb
 2026 18:58:31 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::b437:3b5f:e6c1:3d13%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 18:58:31 +0000
Date: Thu, 12 Feb 2026 10:58:27 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Delay inserting iomem resource until auto
 region commit
Message-ID: <aY4i02aKfLwDYyBR@aschofie-mobl2.lan>
References: <20260212062250.1219043-1-alison.schofield@intel.com>
 <aY4Le-7V5IGKVupg@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aY4Le-7V5IGKVupg@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: SJ0PR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:334::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CO1PR11MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c0437f-86fd-4606-ae67-08de6a68b73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e5B9Ne8uRPlWVDynSEwV0qvqS8TpXwE4InpNJj1+19Y4lRQftVIW8/rb/Q9K?=
 =?us-ascii?Q?NIpHluXlTzPFOct5lmaPLRHoxNDYHrax6f9WUEAbxQH3nq+Jk0jD0jRir5cw?=
 =?us-ascii?Q?bmeEYcp5ivnIw8OiDYE1gPyJkf6jdq1XbM41cPCmXjjo9HID/8OZetV/ocRU?=
 =?us-ascii?Q?oQFlzqd9J4IL0KH4O3o5TlDGvAig8cBBOJM6fnm9K9m5pMxhsVi5KDkjvCm1?=
 =?us-ascii?Q?M8sWQIulYjF0DxS/iNARBWoJNlsJVg2NIR5msCshxkXzvK/mYUxMwjqjSi4K?=
 =?us-ascii?Q?aE06X4k7/SMR++06EDO4j+d0EmorxzCrJBi18An7Vc5IwWqjecV6k4RldxpD?=
 =?us-ascii?Q?G8O8AjYya0EP/UXLo9B9Dd7aP5Wg4zinqVGYGgn5Ay4tETG/LjxoRegSBCqN?=
 =?us-ascii?Q?fCr5+Do61jzR7eB0Er1c7ciY7L3BKIc25ZPkU6KYP79IxR/bE/PjLyFpmdy3?=
 =?us-ascii?Q?AmpO+BeH6JciCZ+SFIMM9cBkA5i5TjJ4I1umPrx4V+fkjwBn5a5LXMvMav1i?=
 =?us-ascii?Q?+c0rXNQpwvZKHkIv12NmxPYdpbq/aGr6k1Ii3Sck33eM2zh7wrsvqbA2GHaG?=
 =?us-ascii?Q?q9qAbuFpvkj3hVJekYXziQukwv+1lgtknPtoY43w90ZAKI9dHO4FOWimmb0l?=
 =?us-ascii?Q?J+RSPE2Wx7SgCx4QExBMvrv2/pYx2+pdUQTOdjobzyk8VcPTCtHs7hzHiT6s?=
 =?us-ascii?Q?oC3I4gatQO9Kqr2PkNxgSzSMwreyPur9gd61fxh11y2ORH7UtE1mf0SPVEQr?=
 =?us-ascii?Q?kOtTtuf377geXyYhgSiomry4/rPFy58ASJ2nkc8+QvfQVQ6FzSS7y+2jp+Bi?=
 =?us-ascii?Q?o/2iRWA9vahKc2DLWdrquuVYIOAPdWenM5G5vg7zye8QVi2mKUxdOxZe0HNa?=
 =?us-ascii?Q?KCttDBJ+yfwzqzpOtOk9x8/MfiuXU+hsV4Myfxs0vBX9xKwmbUBlYnU3iLGQ?=
 =?us-ascii?Q?OlWbqlsgxtQsEcy3eQck1tMR/q+VKitsZXpqNniCVJXSvsM8vRc78sSSghig?=
 =?us-ascii?Q?GAKpv2vDIvZt3ycTKSTKvB2jRGtm7I46l7S617+3VXVr072K9+NVKPsPUKdX?=
 =?us-ascii?Q?SBrbMxuGacmIH7rTpUAEMexRBDdZvjoIicsXTzodC0MQXGng3eumZ5Ejt62N?=
 =?us-ascii?Q?3Va2hYBSY7v6bgmV/90I+gxhDv2b6cOQhZeUQKSHNFUEBAE6S1u00EHBv530?=
 =?us-ascii?Q?hkeuj1/ZfQz6qpDUCNMhLD3zzqz4mn5eG/QQkHyx1nF6vm5nAV7EWKD9pFHq?=
 =?us-ascii?Q?fYawkFr0XqYWgOOQpgMQ784rBXWzDHx7JM5Oe9levtAHwSv/1biVMMrqROBW?=
 =?us-ascii?Q?CIt8YO6gCGpQiwtbmBaNEKxEtf7Y3YEz4H/Y/ipCpvbvFhDn3wSvGQAHnoxf?=
 =?us-ascii?Q?7jHfwbpZYpIWJuOzz0t12HUNoJSHwYqDXszO09XfVxhMzu8mdK6ZLFcX3d7E?=
 =?us-ascii?Q?eULSQdKxVaKi9iN7BC9rYYpfr8/g2bMuEuJX92iOmNVPsLXXV7HUsq414HFT?=
 =?us-ascii?Q?lOGKJ5T5tSj9VbHfnewJ1mS6AZ8jhUGJvNdF74CObqg3YLhBtdsSYWUcFJvs?=
 =?us-ascii?Q?293LI3RdQSuuxsvjsM8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBejihAp/9xDpD1/GVq6tscRcHplBGfrD4hVFYTKdQcca5tDf+qJrgaOadjV?=
 =?us-ascii?Q?Re4Jeq9BooSIT3ERJTOY7cBpFTG94FzrkA9E9/TXcDPQrVRxycMB9Mmx1fB+?=
 =?us-ascii?Q?Dm/sbKWM/dVUQkuhTII9P58RLXPJ+2bK3R2WvoEE7vm+Y7TQZHawAdNsqSvJ?=
 =?us-ascii?Q?a/LymBj6nuUlELiHqJ7WGasJCejy5CWZBa7mRD+MaFOc1B/92UTYAEiQB08e?=
 =?us-ascii?Q?Dyim+uaYsZWusNf1qttaMXJ4N+5DqYpd4J4RQ4j05dw8dGpCXGC3rcMnpqH/?=
 =?us-ascii?Q?88OI33sEiPdv+48OxVux0+LwaM7Hkj31PjgfEw9tAzmYmLD9AZWvQy7Ov6hc?=
 =?us-ascii?Q?SjO2dsfRsIf6Wa2bhgB0Pe84wbFljMwct6gu7REA1b6a0/zmMMh3pvpRFT9q?=
 =?us-ascii?Q?7lQtauZ6U5qjkr7tvb0DBmf0YfncogpNI3AtD4LJXTXGsW2vZHkFTQIWLJBf?=
 =?us-ascii?Q?703EwoiZnh2WkmbepJsKnbqdc9OfMsocR4PrHgYRWqiwzBjfO0akWhG6lKu/?=
 =?us-ascii?Q?PN6DouNPlhfIJ3f5b+lo86BRCTAWYnc6bq6Uwrh17s3d8VvPaGR3j+D8os3G?=
 =?us-ascii?Q?L8DxKLbQP9sa2+Y0EItaLhLo6y9Smb9q0/zWS50t8oG3iDWtxr+IB2vDHe8n?=
 =?us-ascii?Q?oqfBmBdM14x2j5JRLoKIuX2LATU/CbNyeOxxJBOWbivWNuneaKu3zYHHkJUt?=
 =?us-ascii?Q?4+4YjPiIHhhOwwWeXESvoa2IHoI7X5MWtT6q4QfEOHA1ZvlBhMudLcIXn0nh?=
 =?us-ascii?Q?JVzpFYPOSLXTy3YYSW1rdXuF9XDJiumcpDPa0mYU2aSDTGb52JdlSnYZptbi?=
 =?us-ascii?Q?39s0tbnIyCw2gif+gNWoF48kk0VaptV1P3ymLaopJBQJrRgz+YjBaqhFzfjW?=
 =?us-ascii?Q?yUNJz7/VLRGLKreJClvidLlclTo1uP4shLLLTOyG9YywWT6wr4iJYxUFPkwv?=
 =?us-ascii?Q?piDc69H4GQ1IuCaqE9RRwMaXImThTymgsvvjl7tvdaDp+Z3HOEK5HPW/H0C9?=
 =?us-ascii?Q?4yontPhdpfLUh+gM3zy5BBrKy7zKA9JNyHGw+waIkEAWSek7dED48Hlx96VM?=
 =?us-ascii?Q?ui+3l5sfgwiL9IK+476rYdRkMp+XbjGocMUFAjSFhXWy99R19BYlMkNFusNI?=
 =?us-ascii?Q?O3XdzgiBuPqi+vJjgHLPDVBfAGgF0corgn/SEaZE8R12Cw75iwudg6Mh4Jz9?=
 =?us-ascii?Q?m7p94IEeuCGcflctvp+6WNlYrd9//XA/iQFH33JJTXmVjx1g2+U03R1ZIDYZ?=
 =?us-ascii?Q?G6/dsPOKTSOE07gaMWk9HutZkhPROsTMGps4NmcO/gL3rzOZWGoBSEKk4GBx?=
 =?us-ascii?Q?Wsy2sEsaxGfASQbrjF+nAFQ55Ntwy84La42+0BQW++/O7Qu7Pd9Fin1mb9jU?=
 =?us-ascii?Q?tC+KnUqghNi76D/hzgdUjq3s2ddoCY+5BwPMJHGYCf2l7dJdD49IBIHLRPUf?=
 =?us-ascii?Q?dJn/FbIw63AMp0kRlG27H8Sb72u/X1Xh6IzOCXUyVuNfSDMgQZOVETM08hYB?=
 =?us-ascii?Q?huKPTvv7k6ZviY3h6i0gKyBCerSdsvFZVJ8YGheMx7Zd7koyQz8N3kiwoqPU?=
 =?us-ascii?Q?oJi4CrGPF6v4nkUnORMCMizOLPuIoEiKqeb6m/wH8lo0Gf978pN5q4fDuvuR?=
 =?us-ascii?Q?/U45nvWHJL1oug/Atjjn29doHt0SBTIP2sH18gSWqUjNLFOURf7hcc7SHzBd?=
 =?us-ascii?Q?9O28KK8BTMywvlG8UyAn4UwtzgdV/qtihoawlcVYO9CCWBdvIV6A35LeoI4Y?=
 =?us-ascii?Q?uE2UjwEtaFIz9JngNuyqJYX4AQvZFUo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c0437f-86fd-4606-ae67-08de6a68b73f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 18:58:31.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1S9bkKdjRvrPSE+jQzlojbF+AB3EYmYqP/8zHaUuM4V5OiOqDvc3XIDZ60egg/Jn+kaKL9ahLCRbobDm9rDDM43nmHuR2D6FIte6iufPkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 12:18:51PM -0500, Gregory Price wrote:
> On Wed, Feb 11, 2026 at 10:22:46PM -0800, Alison Schofield wrote:
> > During auto region assembly the region driver inserts the region
> > resource into the iomem tree when the first endpoint arrives and
> > region assembly begins. If the region later fails to assemble, the
> > resource can remain stranded in the iomem tree, making it appear like
> > a DAX region is a child of the CXL region, when that is not true.
> > 
> > For example:
> > 68e80000000-8d37fffffff : CXL Window 9
> >   68e80000000-70e7fffffff : Soft Reserved
> >     68e80000000-70e7fffffff : region9
> >       68e80000000-70e7fffffff : dax19.0
> >         68e80000000-70e7fffffff : System RAM (kmem)
> > 
> > In the above case, region9 failed to assemble, yet proc/iomem shows
> > the DAX region as being parented under a CXL region. In reality, the
> > CXL region is in a disabled state and the DAX region is managed by the
> > HMEM driver.
> > 
> > Examining /proc/iomem is one way users inspect the memory topology,
> > and with this patch that view remains accurate.
> > 
> > Delay insertion of the iomem resource until the auto region reaches
> > the commit state. Introduce the res_want_insert field to track whether
> > the region's resource should be inserted into the iomem tree.
> > 
> 
> Can you show the before/after of the iomap failure case just to make it
> explicit what the user sees before / after?  I think I understand, but
> worth just having the explicit data for the failure case in the
> changelog.

Sure, will do in a v2.
Thanks for taking a look!

> 
> Thanks!
> ~Gregory
