Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA11130492
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283607; cv=fail; b=YSo9oaKcfs5YcoK8XSrf8QKWRCqEAWN9jvFgQyXTnLbEFf689C83m42IIkQF4JD4n0ffvZLeGvdWMA0DAY3UNCn568MkjlWPpwgH4kcP/vFUEEeR20s8O0TKtvTWnC60cPLnnaxG9/fOSrtGas9QqtIypiEiEZBwTM9J9+/81SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283607; c=relaxed/simple;
	bh=O2kUFWKbTszctBq79fFAzgxcV0cH18ErebvDyJBCglw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tRSVfJje6+XrOLwpVNaUrnXhLC7SwBaI0lAy0nOaUcQ3KC7idPgUUqaopYeUFrf6ggKro4ABoF6nTq4yh7jQRYkkzqDmBDjnDrsnUgx5eNEh9EevuGLKgHW7dh4w5orYZckY4MjInNT1JtZDbNGd41H6d4Q0Jt4otkzjwD3ta0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTH37k9Y; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTH37k9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713283603; x=1744819603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O2kUFWKbTszctBq79fFAzgxcV0cH18ErebvDyJBCglw=;
  b=GTH37k9Yi059RIuAnVffxv95w7CLkvzl9YPz3Syjv+4hrvX1OVW9832M
   RiVa3xf+lnwdLRSL985bBx6JktPpJExOnS0tdweljoWsigGusFpt5qS+w
   v89L4dBkywyDGHTd7CnY4bhz8YAcHaBmcOCCKln63GYvMNSGzsFi1cDqy
   2cfHJWiScx78IClOviWwPHyRaXdEpyA2HNz4zvC3cI3feNrlMM47meHVD
   nBdGQfRy12f9eciBSD+h7Pub+hQv4fX8qchaPKlSyRPnzgwmRd6P43zVx
   7TW6XWYpFGEDEUoM9Ilb6m2+F7XnTIq3/CcFTK0x0l5XYnlOduB17VB8y
   g==;
X-CSE-ConnectionGUID: 2tSMe1k9SdKkABYBNiISbw==
X-CSE-MsgGUID: zhYQGSRARAGrIXY6AN77Hw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="19441575"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="19441575"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 09:05:38 -0700
X-CSE-ConnectionGUID: 8vk4eewhTHGxZsbxkUUFRg==
X-CSE-MsgGUID: HGquDDZ0Tk+3ltcpy0lD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22372915"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 09:05:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 09:05:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 09:05:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 09:05:35 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 09:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNl+brVdgNaSzd7ZSNWceHr2mpak3pLUA9PWDfg6VMe2sRexeP6tJpBFastIO6V5mzHcffay4h17DQMw92gFZdjFHSxiPOZOJ4DnLhUwqlsWiiqMtpateKZ4sondoCeE9pTVZLEqQIEQvrfr6f6qeAPeCs+Es9FOtRTmbulYuMO62QrhYLxKLTiptbvFPbqZM4pTUvBqSQAGMifoFbw/1yyjdth57JoK7mQ62tgE291llQYeoP3lQBdYKsoHkj1gHmELYARbuEUk44KVL8Sj5TLThTMa33jbb6yWj5WGHvKLMxdXKj3roWu+9uFKFkpQQeiggdxXWRR+iNFia9ilag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx9dZJVlqZHmW3eQlLWWtyuyn7U+QKVNqaKydzfOCzo=;
 b=CT6ZDRSTJihJakvWUxnDL08Psze3AlCHqhJT1hT8W2iDR0LIpxyySYsYdsiNKIHyQLFdKgi/ROtRYM5YrklDhVFrwWy7RgcuNkRaqiYsrEV71OlD58N6dhvh0lSbQUKmENdWVYNOIsOKdryHvzUXEs8e9ImznvMQq3yB6GAW5+l2zRtbElrySi32Nncs/CxZLOpYsJ7SRlr883RWBQ1EXyV9EluiNf48C7PrKnRK4+nCaBbUwxemFYo51X05m1FWb6HRKUk0f3zpyc0n7NgclYUY8bAmmTUGsw0Sk1Je7gwmeueCJ6N4MX54myCDWtEAuV2mc+OCJLEEJ45nRigwIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by LV8PR11MB8747.namprd11.prod.outlook.com (2603:10b6:408:206::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 16 Apr
 2024 16:05:29 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5c74:8206:b635:e10e%7]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 16:05:29 +0000
Date: Tue, 16 Apr 2024 09:05:26 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/4] cxl/region: Move cxl_trace_hpa() work to the region
 driver
Message-ID: <661ea1c668bf1_3f18292948b@iweiny-mobl.notmuch>
References: <cover.1711598777.git.alison.schofield@intel.com>
 <0174dc9414d4beb71828f66e173a8fcc4ebe76ab.1711598777.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0174dc9414d4beb71828f66e173a8fcc4ebe76ab.1711598777.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:a03:333::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|LV8PR11MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: fb5825d5-e41e-458f-cec7-08dc5e2f0933
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?36a1Qk96v92O7q/JGRG+/fxD1dRuFxjuKqMxYKWxcODrGtnpGn7i5nk4IVPV?=
 =?us-ascii?Q?HoZFdBmiyv60yFQ5Us4SXEU5NiEoeojQcqZgSwOZnppXm0UK0dIi0+Uzi4Wh?=
 =?us-ascii?Q?a+prwheWP6PvbS4WjKiV7IsemYBx+q5UlQvvYayvZXNg4SIjn2RRF4aSbwpM?=
 =?us-ascii?Q?zLpcnDSuXEpLaaDU6e//cSBgxlwbWXJhho/RSbJZmQSTccKb3z5WVt2Hukav?=
 =?us-ascii?Q?iP7TJTPBdlx4Ztu2i/Etb9zofU7mRjXaTOUM1/GJoY2G61sYLBGsu6vUQdns?=
 =?us-ascii?Q?znxfPe3UGoWOyL7hKMor3LmoNbBunUJvZlzHLANsysH/xWQV71wJpM3vrySk?=
 =?us-ascii?Q?1i+RHlYH+K98tRpCYQttNBrDE5dKsAqBvPJUGmV1pGs2+f698nuBePLOHxY6?=
 =?us-ascii?Q?50xMADsDbsGeJvUg2zzbYD+qK8Sg246izYeyWpi69Iv3sH41vrfgOpvsXpfl?=
 =?us-ascii?Q?p43Ay4/a3RSOxW4cYx1XAvyLA2cs14ysyfPJ+0fz57ZTrjpQtwZWUScCuIbL?=
 =?us-ascii?Q?3T8wqdwBtfNH8EtvzN1m1J2MrWN6IfXy5muCzOjc1JgqqpHQXQfudu15eHTS?=
 =?us-ascii?Q?4w1FrqfJciIjdUrWjLeNJP0Q3uT9j82gcW6ygbV+DiROUv+QaiosUrXJThIn?=
 =?us-ascii?Q?iGGOto/6J68w32vW5rfWgtQ5TrWg1Eh6DHaTor+W8TRQJt7UgwcA0TPmgELw?=
 =?us-ascii?Q?YTuJfnlhmUn/gNS7jAHvVW3jDrv+qAbZRZDSvA45s9rwboppREeFz7mQh8Eo?=
 =?us-ascii?Q?rNX/2dHJndYDbHDGtox9qfTZfYhnAV/Y1xNQAdVocJULynN4fwmKu0998RkP?=
 =?us-ascii?Q?nBUPyvyJ+1M3LIN8FeAcnpC4ltndTN8jwwqvnTf0Es8ucoExfPYnKiEij0o0?=
 =?us-ascii?Q?fl+kTh3wNccrlyxVO0zKn04w9zo8sC4ppPFVSausPHN5hdpZNaW/eNYmD5PV?=
 =?us-ascii?Q?ZKXuEinWgC3+lx/oHVfb5ilmMKqaFUCMStrEoPBWytIPF06K2OAcGyYsMtLc?=
 =?us-ascii?Q?YtJ1n9W6UX1RXn7DlPg3ooruNz4OcPc33PtArSCwMf4pIWbc3mXA+U+pYTJl?=
 =?us-ascii?Q?FspiUk39fwJSfEWeFIcbTcBDcAKapaQxnPA2oxfOksQk4O8EexrIaOLzNgfv?=
 =?us-ascii?Q?q/KUkCHum8ORpCj54iMEq8DbqLsQoicTXPjQfhRMQui6XHVgSew8LZowfcbs?=
 =?us-ascii?Q?rpQ8GVw5FNzL01zIo9zp4XoyutyveVuKXoM6lE7zzd3YBNyalF4TAVrg7J4l?=
 =?us-ascii?Q?ucHZUax33bPEVpPgQvOJ4F6PQD9bfZqoTbHSrqHwLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VGXq2tN7mKOZ6bPGXcjOJDUoj7MvzOmuSlsGXBhkIHCVczu0HdEIwXF2scbl?=
 =?us-ascii?Q?JjEsW9muiHuJgb8K5N5ZrrpHwD9fEMPWvb9CBIt9cdWVH47FX5YWnVf5XplF?=
 =?us-ascii?Q?nhb5yaiAxvlBdpxy2vTGifNy71rsBMayz75Z8nfrForM28ql+sVEM3zaBgos?=
 =?us-ascii?Q?tejzS52RT6kUUEp0RrzKp6pcmfYQ1lAU5fu2AZmtqh3vPiPekSkRzLWLifU0?=
 =?us-ascii?Q?wB1o084wHmNgtz4vqFBPUeTpjfc2KYQlP9pxNnkM+hdcbvxLQ4g4e4uvWz3F?=
 =?us-ascii?Q?J/7OFRQ+FjEJfLhU7m2PC37CHHq9aDKuYbz9OvbJYC/j0eEOL/qoqqSNHC5l?=
 =?us-ascii?Q?P1Jxu81KKbpB+s0v89l/GfIYq5VoIefaC9CBwqJmSvS8OuHq0h7AbjmdqrJj?=
 =?us-ascii?Q?j2DXVy7jvi555dr0SROX+YYQbmmWcPoW0AW5/nYl57Ln70cJ8ZD2I4N2BhIz?=
 =?us-ascii?Q?MUB9QqjJQ/HggtvF/0+XwlltxAc9+FuLJy/rbb9+Fm6ap3FYvCXckjCMPolB?=
 =?us-ascii?Q?FOl36FgxxGo98bvCfvxzTG+i6j/V7+9/7WPM65kk6KoKUIeWx8W0S1ELiPuY?=
 =?us-ascii?Q?dNAB4rUFF7j6Th/KsuCSbcIua3UyNHcVpBprQpUigh7YBrZUqpcYO/7ux1my?=
 =?us-ascii?Q?9rAsh6NC7hOlJuhOU9qy8N7OqbC6BGsDbEt/g/Q/Lqr2ZXPP9IfxVEYCaP+5?=
 =?us-ascii?Q?zTAG3PQE6a63lOa1aGOBccMjzZAxMRrfG788tWWVnViivEhWkWWzhjf1RkVB?=
 =?us-ascii?Q?92vFwURgLlDsjR6NbUhFzjby0vlFtLFXga1cjY2YND/6/kkPWq6D20BJiHDh?=
 =?us-ascii?Q?fx1Fu+1jqoxAz00CSYvxKPvJRRAXAT1uv+EhdF64SRt50Ek0Is3G74Ni9kVb?=
 =?us-ascii?Q?rNFsR5VieJmjuSMf4NdN+FjgxshjEHA1DxSyfarqdEOKe4EXn2co/WLzpdsi?=
 =?us-ascii?Q?yQeWrOH/hhtTxcX7yaTmyF0GHkabjFwu1RSNGeiuon8xmNCc1LCMlOCjZ24J?=
 =?us-ascii?Q?bZSeID61IT1d2ftCGtCvGrRBljt+ZcuQdJ2r+R0tdcPdNrJSW4zNakTLOsMa?=
 =?us-ascii?Q?GcJ41hT/3NlYVKjX8Gy1YUYgZTRleYYI32ExXmN3WWSYILVzVe3arxj9fOBP?=
 =?us-ascii?Q?iWikRKrRyJyW0BPYtQraz/RIy4UqGwicAv70+DFfdkvv1OxGeIxfbSTJy4eP?=
 =?us-ascii?Q?Jth2k8qtC/AUqSxyRUbbz9St5UVMZBpg+qb/8LtD6rfYpI4JOKhPc7EO+pbs?=
 =?us-ascii?Q?8o4NJ//Q0bTTOHwfYwOA7Ym4nLd1CIaLA2NWDcuhXpHlckIO84T81i3T+Ng6?=
 =?us-ascii?Q?0ADLCrY7DQjBf0+OuhtLxaxSi+lscFl4PMSSPB3wP0nBWC/QUnfjp5VeqJCr?=
 =?us-ascii?Q?iTaC3bZ46Vjzi6Gc2OBH32sR9VOmgyEV0JbuVUYuFvPSpu7thAcIoD6DXEhX?=
 =?us-ascii?Q?cAv5V4FJRRy0s0RTsT+HsjDgXmThr5kgVcZc9xXg8vocnt7JFOxVs2f8ODIt?=
 =?us-ascii?Q?o9du8kjd5UPw9sCPXggCrlLLy/E6MSHg+BBeaFMjZencFQtR48kyR6jjnV60?=
 =?us-ascii?Q?aUeStjSPu5H6mIvwQCzuAQDGlmCJ85fk3Ga3Vn9H?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5825d5-e41e-458f-cec7-08dc5e2f0933
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:05:29.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6BNpypXDDzuNUkAku4AfBN1oZVUlyiKpdMMy8iIOaR1JT31vOeqEdZksNWG1WNw9c7F/W/lt4wYQmgwLr0low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8747
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> This work belongs in the region driver as it is only useful with
> CONFIG_CXL_REGION. Add stubs in core.h for when the region driver
> is not built.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
