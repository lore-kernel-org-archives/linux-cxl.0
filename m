Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057B38384
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445199; cv=fail; b=H5zPLgeI6WjzjH1gh3ULMvMu1tkmxe8E3cUBmlhijetY6EgBxRiVxFx2IJkuxG71qUlcUvLUFiA0Himp2JHjZdWeNeTJv3xczDEMfYOje+3FVmKQPR3py2wbJIl366jqEBiE0B3L7bvCwqMs52Io/xibpJFf7p4Lvh3VS4jRuNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445199; c=relaxed/simple;
	bh=OQQi5PT4IN0eAMl7xgQSO1gkdlIK8CJb500WFgOLxuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qc7egj40MZDTK9lkIJyTofFwIuLaIPiQJMbrMtUW3ZzQg5nhKP1kUkOLsB7eaDxCtGZyg0tyzh3/EwGOwv+n3ET+ogLbi7yZpwV7/wBLZK6uC3Hjhkp/iAlhFXBg6uMtpxx6pTIefu2wYmNT5oGHzaaN++w1hHTLL9bV3ZrmIwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqtv0aIC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqtv0aIC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733445196; x=1764981196;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OQQi5PT4IN0eAMl7xgQSO1gkdlIK8CJb500WFgOLxuQ=;
  b=lqtv0aIC8YgeA9QD41zqAYfa57G4W19cf4kdxzXYaL8dKcKbJZkabshR
   sgJUXXAurOlci4vz5Co6oZIPvG0/cHsKDFiHVpBWkyHAxsWfBilRchVt5
   5BiEXdFMYUxX0vJq4NuH2VpyXpuVKIslnZalyyj3V04nQrEGz81cmVFY2
   BWOEPdmztb4YymtlVtXqLX8rumNNAef6LC1GHxiNrTbSpYopK1sCnpyFF
   iIA/Z9H1vL6OiJF4D70dSW1Eqda6ltdSpg1ggKkqLJXQmINiinXr/OTFz
   H+GRsvv7a0oXclR6dBKjj+AlzLXkdS0KDKR+FW7MBGZez/O0VGdNaPKRa
   A==;
X-CSE-ConnectionGUID: MwmfndIJQBuuvSdkNkrYaA==
X-CSE-MsgGUID: Yb3qylBFT8KqGFvUcEYJUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33137453"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33137453"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:33:16 -0800
X-CSE-ConnectionGUID: WWceM5EgQlqxOr2tfUKZ8A==
X-CSE-MsgGUID: c1LXxdtvQrCmwWskVEvi6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94732223"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:33:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:33:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:33:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:33:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFXmGDRGvYloMbL22UjyOWTFTr2dBLhaVf9FRPjux/WPo/6GloaFiKNaBs6t0b+ou0pUmkMZ2nYtEWtU0rY4m57+ZT9RFyZbdcOwLPxdA710hqKINgu8qpeRl9WoYQmS3MJatb2JQnzbEfCu9D7THJT7kLJQw6OUIjHRHZTPHpqvlLHPbbStZv4qmQHiw2TwGC5A6ncdIWmIHR1LlVAp9fKsYUwdFt1fwU5gX5SJBrdIIAolqfWU/aSVyN9OZK36JPGjtinC3P/GbkdbnbgzqqwQjJ+an/a+UgjdLXUJubR6viGBQRA5PUbkqDnV+d2tK6gxyh/zmVuUz7JV/wQ2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bbLolHO0KjrcKaGVIbO6xC7vUq1SlZ2NUPtMeSzx74=;
 b=srJ7ZhSnwkJEwiE3z3hfkrAPDraK8SB6al13KjDph1MUFW8G1ROwyzWmxqmsMRS6M+Bazx5GS+WF2TCHNwjCtEIanpj2wjeVUGqHCWsIbjkm2sY5fSY1evD2WiT0xHog+aM3w3UgzTaAd2N4oQaI90GBv1fz9KoSzNMoqfIpJuAeL/tSjozi/HhDh6OVhNwsqSW+yV4KkC0JDPFVclcTFEEIYFyd4v6VMMe2TKDaXHwDO6l9aFk+R15k/JmUH2t5scRL6crSRwoUlL0OV6UWOQQam1Ti3CWMYbj9C9ajvKoE5S7tJu3ADEyv8501sftbZbBor2dPxw/yX04nlTnokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7500.namprd11.prod.outlook.com (2603:10b6:510:275::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 00:33:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:33:03 +0000
Date: Thu, 5 Dec 2024 16:33:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 02/20] cxl: Add Get Supported Features command for
 kernel usage
Message-ID: <6752463d2710d_250732949d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-3-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0112.namprd04.prod.outlook.com
 (2603:10b6:303:83::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1bbe3f-4c8a-48cb-d21c-08dd158d8b87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LKcZ5lcW79II1AV29/i6Kd6qGcnUBHlSdOS37gCDBLmQ2IGGaiCCIsM4O4zr?=
 =?us-ascii?Q?K4sX84NTGDpASqBBo9kvT8o7iv4GrebxtP3VGpYote4ZbxWELEGg7TTCFu1r?=
 =?us-ascii?Q?/suxzYXqwqH/7xB9PhddC+xKbvpuvl2yiGGWPWpdA+VDKHs+grm4FUo3hiGO?=
 =?us-ascii?Q?tN+JCLlFxGNkdwyrbhATsDW9CvO+6Xm/3ej8lqM6LeJ25Ke9fbl0xi1AFctd?=
 =?us-ascii?Q?v9tBYIzODkjJNsH4lRY8LH34fS84zLJW68ExFaNG99iQyoSPtTnLVslaHCW9?=
 =?us-ascii?Q?Jn7puwqv62QVWG3zeOnawIWDxs1oBqGEQHBCJ1AkkJFY+pmpCg8d7T7fYpZX?=
 =?us-ascii?Q?13brdbTwIQzd3JlCOHKFuRl95bP6IXHusySDGq9EgqEAvzy8fZsR3/OPtstL?=
 =?us-ascii?Q?0nu974Luu31rpaacSmlgEkZnbogZHKSiRr120XBFi3mqvH12/UV5SBSIHWZz?=
 =?us-ascii?Q?fMuqY/kcK0WftekbfTyV5QtQn9FCQnG5WryWGT92Qy3souefLcXlvjHkx9Au?=
 =?us-ascii?Q?jXZPdsszlS71/2nNR6TO73K0vypmMXa/brz2cd1a73WaFnt0DkaUaieFOKeU?=
 =?us-ascii?Q?HO4pEVtVBo4wQavPMF5Nw4gKx7jLbLmfbUADewYHSinGfDt4dNcRk+IYdXAW?=
 =?us-ascii?Q?ZcnEVJmKTa0akOdEqg4ynZsgPGh0DYv4123Z6ltht6PPs4bkTUWTyAjngH8s?=
 =?us-ascii?Q?Imq+/6SKvcSFoXgksGH4yAgT1ueahNCi9oz5GiuAn9fSF0ck+fLhfpjW9wLH?=
 =?us-ascii?Q?updMFBjwem7R564KhnLscXXsvrtUDtVZkY1j1G3Hf5WHHoxisUT6mhwV4ogH?=
 =?us-ascii?Q?cipAk+uUhEbItIYNd9SogvfGmtwKddIkwuMB6nlffk5chTKqrSsxAopHlySS?=
 =?us-ascii?Q?hJT6GtyKcQPX1WvATUJnPKeyoW+mMhGeYvG9j6Px4vVtn/vncbWF1xtCrH8z?=
 =?us-ascii?Q?xGilxf50k+Zvlazy5W1UUQA6ZaqtQN7EKAvnKvkg8TGsEendFpKgayhaB8nQ?=
 =?us-ascii?Q?O/cX9xVJj4kPE/T6XUZexmv3HBqNCna4TtYc5xTEpSqtsoXobtoJb12GfYME?=
 =?us-ascii?Q?vQv81i3KEXoKEDUKixHiKTVlerqWrmiHYDx5Xdh4X5Ctt0KZyy3/mvZFbVQ8?=
 =?us-ascii?Q?VOGod4RvUcQvFmN6pHDIrp16HxEUAJjYWIlGuQib6vZMImm7T4gSaEYqQqu+?=
 =?us-ascii?Q?HrlItzD4M48CJhOqIOgofgTSYSjAiNR8Q41JIYY+iy6kUh8mgvfmQIPwOPg6?=
 =?us-ascii?Q?4Jvfhzw8QPPtDP2AEJMFCHL9lZYIsFJN6Zb9zSXQ9wSjqso+Ypkcoxk4ngQ+?=
 =?us-ascii?Q?isI+c3sQEMSxjiJsi2AxmlpjxbMJZg6pwOyPBX/M8xuUIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2bNxghTmh7qP0BE9HHbISxQ3F5jZCWdMPgJbzKL0JFYeCk1AHVeUkQh0fZK8?=
 =?us-ascii?Q?VYY7AKWsUSGcfElqQvX8TJbCSs3Vy1K1/MtM2qx2zXK9Yii4VlfosTwCLWSc?=
 =?us-ascii?Q?PgZ06srsXgv6Eymkob08/L66r3OLzrflODprlZ1RWt8HgMm/oO9CsttGh8HQ?=
 =?us-ascii?Q?XdwG0O4TxELXBGrEm1HvCPOjbKlsmQBiiPjAKDTA4e6t5oB+XaaMG+TiCYQL?=
 =?us-ascii?Q?6N5z7zwC/7D5qJgy1UvgS/bwZ6rGruOGRlsYyigbY/dfHlhSqYiXXAGqfgtJ?=
 =?us-ascii?Q?bBRcU8WFm3SZ8ziAGkHbIdyfhX8TVb/l5hkCO962sScy5JewZPoG9lTMoeYO?=
 =?us-ascii?Q?U72KG8x9xczKJBwaLzC5iUDo3LAiF550dhNYW2q2zBrRxnn+EZ0gtg4F5j3M?=
 =?us-ascii?Q?n5c2dFMj8VBWu/9Yws1F+iLgd9ghIc8YLhm/ufsojOBxHFK3GLfiEz7AAWds?=
 =?us-ascii?Q?c+pzlRzlgIqPuElvElW0+hiZP7FWZZRsPzTwY9jRh2FxWQWbCurNNiQWjkEL?=
 =?us-ascii?Q?cSkHTLzHGcbwV+TqUCL7TKNU3g+A3OxrE/jdqYodd3/dla7Yl2Cx2WJUUGRY?=
 =?us-ascii?Q?A0izetJ8kJiDxFTFOEg/2dCggl4TVzwWholabuim84RA3EE8Owv9OVorMRSQ?=
 =?us-ascii?Q?S66GiT3drf6YTZbbdb5X9nsWz5bu9ktg1eiS8d3o4CL8byp1xsFHTh1Gvy7Y?=
 =?us-ascii?Q?6Wyy90e+a9f1snIcUg8ki0NwPC4aeQ5XGxZjQA8YYDlgTaPzazV8bLoYVdNY?=
 =?us-ascii?Q?DtFAh5zvsbthPpyikvhaXUZmFW1NSPJGevfqnqS1bAn6Dhgz4xXwKNiUOgYx?=
 =?us-ascii?Q?7cSsd9HDII3XLTOlqr9M0Fxr34F9RnF5WvFlvH+ElGRIR7kCyFkvn7ByZUJ/?=
 =?us-ascii?Q?xEdcuDV6s4/UwBhDLLM6t6nY7rWEEepAx5EKaf21kAuh3apdeSHVMtG1VLAt?=
 =?us-ascii?Q?0tobYsvuahTm8rnwGaqkJWMw4x0PFuAwJBsZtnyTFqyqnD9wBOcGcx3+Dhqk?=
 =?us-ascii?Q?3cdzDzBgAlPDDtSX2+udq0n7+i6xjTvtMdJuZsIcWW60OeFel9ZL2BdgXbrf?=
 =?us-ascii?Q?vwA5H07EeJzS5Xx0HuXhnmlfCJYwa6q3OCSD1bt0kw3ioIHi56UkgAvWA3Ou?=
 =?us-ascii?Q?4MXH4bFA1At6e/OK6kr+kyJiZSOV7+65i1g/BiuuNaHn/jj0rWSTNdysgtmn?=
 =?us-ascii?Q?FAZbw/PDmZTZuCqnyVJvtTNPpE0u92ffkHogTZ9C45xilP4xZpmpyeyJRedm?=
 =?us-ascii?Q?4sZAEYeaPJgyLurL3ME+R7kaVv9UhKQQ5QxttckrT+4QJhzkhk01Jgy59AuO?=
 =?us-ascii?Q?j08ujVu93R/fsPZnsGM5KH9pdqRvpEqwa18+h8BYK+C48wRmmmB/NB5PIvu0?=
 =?us-ascii?Q?jQUD2T+ymJ3Q2GpTpCBTGq4VLNSxO6AxjwNSsGvVT1Riz1hw0/BeTaURAyZc?=
 =?us-ascii?Q?vMB0ys0onB4PZii5QHe+QHqzak7OrRwPFTFLB4Mz84Nl0VYuAgXZof7apjqs?=
 =?us-ascii?Q?mP0rGRFc2hhqXQo7OycFkw/okH5E7W8ltxS6GLgHJaRzGgTAh4sPek9VcPVU?=
 =?us-ascii?Q?ZnMKYb5ztu3wP2Vz81zq1hrFReGbOWG3wYp+vyKcwHFyVlfZM+tupo6SWRz6?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1bbe3f-4c8a-48cb-d21c-08dd158d8b87
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 00:33:03.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrKJCsV5vlgEhJKeRfmWgXk4NdwFN9bcOxhKdpunTTkqW6DtwCtLmaf+XNXsEIpNXAbVVGpFxKyFa+4gN7sR1QM9XAWG4EyRN7VGktB5hls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7500
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
> The command retrieve the list of supported device-specific features
> (identified by UUID) and general information about each Feature.
> 
> The driver will retrieve the feature entries in order to make checks and
> provide information for the Get Feature and Set Feature command. One of
> the main piece of information retrieved are the effects a Set Feature
> command would have for a particular feature.
> 
> Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> v2:
> - fix feature entry pointer math.
> - free mbox_out in cxl_get_supported_features(). (Shiju, Jonathan)
> - replace sizeof(struct) with feat_size. (Shiju)
> - replace reserved in feature structs with u8 type. (Shiju)
> - change cxl_feat_entry->effects to set_effects. (Shiju)
> - rearrange assigment of cxl_mbox->entries. (Jonathan)
> - Separate no features from actual error. (Jonathan)
> - Fix missing kdoc for entries. (Jonathan)
> ---
>  drivers/cxl/core/mbox.c      | 178 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h         |  31 ++++++
>  drivers/cxl/pci.c            |   4 +
>  include/cxl/mailbox.h        |   4 +
>  include/uapi/linux/cxl_mem.h |   1 +
>  5 files changed, 218 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 880ac1dba3cc..4ba56f3d5a65 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -67,6 +67,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
>  	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
> +	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),

Since this patch is only about internal usage then no need for a
cxl_mem_commands entry which is the translation from CXL mailbox
op-codes to user CXL commands ids.

I think ideally CXL features ABI is only ever a fwctl concern. Lets try
to see if we can get away with never defining a CXL user command code
for them.

>  };
>  
>  /*
> @@ -790,6 +791,183 @@ static const uuid_t log_uuid[] = {
>  	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
>  };
>  
> +static void cxl_free_features(void *features)
> +{
> +	kvfree(features);
> +}
> +
> +static int cxl_get_supported_features_count(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	struct cxl_mbox_get_sup_feats_out mbox_out;
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	memset(&mbox_in, 0, sizeof(mbox_in));
> +	mbox_in.count = cpu_to_le32(sizeof(mbox_out));
> +	memset(&mbox_out, 0, sizeof(mbox_out));
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
> +		.size_in = sizeof(mbox_in),
> +		.payload_in = &mbox_in,
> +		.size_out = sizeof(mbox_out),
> +		.payload_out = &mbox_out,
> +		.min_out = sizeof(mbox_out),
> +	};
> +	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +	if (rc < 0)
> +		return rc;
> +
> +	cxl_mbox->num_features = le16_to_cpu(mbox_out.supported_feats);

I think this function should return a positive number of features or a
negative error code, more below...

> +
> +	return 0;
> +}
> +
> +int cxl_get_supported_features(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) = NULL;
> +	int remain_feats, max_size, max_feats, start, rc;
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	int feat_size = sizeof(struct cxl_feat_entry);
> +	struct cxl_mbox_get_sup_feats_in mbox_in;
> +	int hdr_size = sizeof(*mbox_out);
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_mem_command *cmd;
> +	struct cxl_feat_entry *entry;
> +
> +	/* Get supported features is optional, need to check */
> +	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
> +	if (!cmd)
> +		return -EOPNOTSUPP;
> +	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
> +		return -EOPNOTSUPP;
> +
> +	rc = cxl_get_supported_features_count(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	if (!cxl_mbox->num_features) {
> +		dev_dbg(cxl_mbox->host, "No CXL features enumerated.\n");
> +		return 0;
> +	}
> +
> +	struct cxl_feat_entry *entries __free(kvfree) =
> +		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
> +
> +	if (!entries)
> +		return -ENOMEM;
> +
> +	max_size = cxl_mbox->payload_size - hdr_size;
> +	/* max feat entries that can fit in mailbox max payload size */
> +	max_feats = max_size / feat_size;
> +	entry = &entries[0];
> +
> +	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> +	if (!mbox_out)
> +		return -ENOMEM;
> +
> +	start = 0;
> +	remain_feats = cxl_mbox->num_features;
> +	do {
[..]
> +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> +		if (rc < 0)
> +			return rc;

Hmm, why "return rc" here, but "goto err" below?

> +		if (mbox_cmd.size_out <= hdr_size) {
> +			rc = -ENXIO;
> +			goto err;

So one of my new code smells for "needs more care" is cases where
scoped-based-cleanup functions are still mixed with usage of "goto".

In this case there are two dependent things to cleanup on error, "reset
cxl_mbox->num_features" and "free @entries". So, to eliminate the goto,
how about eliminate one of the things to cleanup with something like
this:

	struct cxl_features {
		int num_features;
		struct cxl_feat_entry entries[] __counted_by(num_features);
	};
	
	count = cxl_get_supported_features_count(cxl_mbox);
	if (count <= 0)
		return ...
	
	struct cxl_features *features = __free(kvfree) =
	        kvmalloc(struct_size(features, entries, count), GFP_KERNEL);
	
	features->num_features = count;

...and then use "cxl_mbox->features == NULL" as your "no features" case.


> +		}
> +
> +		/*
> +		 * Make sure retrieved out buffer is multiple of feature
> +		 * entries.
> +		 */
> +		retrieved = mbox_cmd.size_out - hdr_size;
> +		if (retrieved % feat_size) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		num_entries = le16_to_cpu(mbox_out->num_entries);
> +		/*
> +		 * If the reported output entries * defined entry size !=
> +		 * retrieved output bytes, then the output package is incorrect.
> +		 */
> +		if (num_entries * feat_size != retrieved) {
> +			rc = -ENXIO;
> +			goto err;
> +		}
> +
> +		memcpy(entry, mbox_out->ents, retrieved);
> +		entry++;
> +		/*
> +		 * If the number of output entries is less than expected, add the
> +		 * remaining entries to the next batch.
> +		 */
> +		remain_feats += copy_feats - num_entries;
> +		start += num_entries;
> +	} while (remain_feats);
> +
> +	cxl_mbox->entries = no_free_ptr(entries);
> +	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
> +				      cxl_mbox->entries);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +
> +err:
> +	cxl_mbox->num_features = 0;
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
> +
> +int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
> +				    struct cxl_feat_entry *feat_entry_out)
> +{
> +	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
> +	struct cxl_feat_entry *feat_entry;
> +	int count;
> +
> +	/* Check CXL dev supports the feature */
> +	feat_entry = &cxl_mbox->entries[0];
> +	for (count = 0; count < cxl_mbox->num_features; count++, feat_entry++) {
> +		if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
> +			memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));

Why copy-out? Would it not be sufficient to just return the index in the
features->entries[] array?

[..]
> diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
> index cc894f07a435..03c4b8ad84c1 100644
> --- a/include/cxl/mailbox.h
> +++ b/include/cxl/mailbox.h
> @@ -50,6 +50,8 @@ struct cxl_mbox_cmd {
>   *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
>   * @mbox_mutex: mutex protects device mailbox and firmware
>   * @mbox_wait: rcuwait for mailbox
> + * @num_features: number of supported features entries
> + * @features: list of supported feature entries
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   */
>  struct cxl_mailbox {
> @@ -59,6 +61,8 @@ struct cxl_mailbox {
>  	size_t payload_size;
>  	struct mutex mbox_mutex; /* lock to protect mailbox context */
>  	struct rcuwait mbox_wait;
> +	int num_features;
> +	struct cxl_feat_entry *entries;
>  	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
>  };
>  
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index c6c0fe27495d..bd2535962f70 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -50,6 +50,7 @@
>  	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
>  	___C(CLEAR_LOG, "Clear Log"),					  \
>  	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
> +	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \

Again, for a patch that claims to be kernel internal only enabling, lets
keep it internal-only.
