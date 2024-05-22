Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192264C7C;
	Wed, 22 May 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385513; cv=fail; b=HC9Lgwo1pTQy0ZQ0Gbb19DkdzMxoPZm66Otc00VVTO2UwcWo8WhVcSVEJDuqOYpG5g0vWtYtzJRb5/2+Zj6Y9ZoQnxeVzZSAMbOi2DAs4OxJtNB17M6GfKihMeXFBZcliLrY2se8s8fXkvVypCU/cj0hQ4WGWP/uNLpw9COXtcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385513; c=relaxed/simple;
	bh=VdwTU6mALzIV2UVAB2GTjyWOJwZ/0nmspaDs9YVzBKQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=apI8fXLwSH95gi/xU13bvOBEt79spy9FuI4/cKElSSvN7MAJVe9TCqCiZR4us+QHxs5USVqkuiestpJhE85cg2dQpTv3CIsqttzwkXka068e2tBJyUALtO0eV7/RI43jcJvDJwOsw6U47mNODGCJ4RisI8tVsPtJPzqww2B1OYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbYeAnb2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbYeAnb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716385511; x=1747921511;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VdwTU6mALzIV2UVAB2GTjyWOJwZ/0nmspaDs9YVzBKQ=;
  b=MbYeAnb25eqcB2kEMk6iJZnH0JpK0rBlNRTgGYuDLLLik/UUG6CG1uED
   lEHnbIKgtyejXoa+MRsl1cN8i4/Eh2g8j598sC9wPddFR4gz1poXdjVpy
   48s3zEhsM5XgidY1zlg3jh8c23JOE2Ld+OrlY9ImLBYeRLzOCy3yKHcHZ
   2Fh5tNGzxZ9LnDgaERKmjjTZPcobg81gNTFiP3fPAL+8ddYlUliC/8CQh
   229dOwMrF+Ayr53pzYbvc+ydclcKhfnEnCTXhtcelKzAXtYPLNIFkO83B
   Ktjf4ax9KbbGrU2Iw4JwuRHgjYCGzKPEr3mnb5NyCCH9TyBrxwN1QG/4G
   w==;
X-CSE-ConnectionGUID: YPfqaFlsRcGeAK4qQZNbBA==
X-CSE-MsgGUID: zIqhfvO8Tvmp7CZfDL0l/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="30141291"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="30141291"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 06:45:10 -0700
X-CSE-ConnectionGUID: xiEcL6XfSVW3KjmOnKXQCw==
X-CSE-MsgGUID: feTRNhQ9TOOppIYZkwlcBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="33365437"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 06:45:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 06:45:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 06:45:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 06:45:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 06:45:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF1g4OtmSIBXGxNKnWD8ffW08v8hFkA6kDwJKxFMZLs4w+cAEWUggAK5WFd7LOrY+CyWWuZSFhWnCLUQHiJyPoZzyaLhB8b+c/znQjEMUEEID0gYj+KfICNuRN/QRw1MbmP+/wr0QP2iRR9eb8f6LqTx1GSf89MQ/HIWLdiYKxAFMu3GlgO2/Vd9GR6479mWP1IzSYd7pSdM/NwJQUsLHopo5U6YVnUN1A+H6hhIW5RILy1cHI+kWhLv+8HuRiKA7087FWQ75A9eimifhnqQXmR4J71SyoiNj+a9hRukNEDgffiIFu2lDE5nufznQSel+38QfpkYnXzN1PXlTQaa5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trnuFUjHIlkKcJeVnx81/QU6nK+c3TS9Gwo2MjugRzI=;
 b=FeSwxAxt7ioGZk0oy1onzVI0FbHMWYdCE7sb3fYimtC6zFB3gFGKhbMMHZnJ0qE0gVKbXEc0HtDTfAC9x6Vykl33ZG/hDHgHKS3lIEMiJMvccdNfPzu/AL89sr2b4+msjZzAaxi5x6jcdZ9rJKgbHFMgxl7882q9S2cIaVyU0V5PmubybBggk1DJVcn4oyDQiaRd5wmsfyMBV+6CevR4u2iSRgcLS/WGKkEcKe0woI1AqE0dbnuZFiwVTm21jhEK84TX5QExzht7rMqGhH89Vxm/OoZpcGJv5VwWF1GTSkybZA9i+jrq/N7ot40n2i148jka3yn7mjUzvR1TscA9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.38; Wed, 22 May
 2024 13:45:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 13:45:05 +0000
Date: Wed, 22 May 2024 08:45:01 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v4] cxl/events: Use a common struct for DRAM and General
 Media events
Message-ID: <664df6dd4637c_3ce88294ec@iweiny-mobl.notmuch>
References: <20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240521140750.26035-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW3PR11MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: a26bbaee-bc5b-4708-9aee-08dc7a65630e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LEU9aS0rFhyRFjrBrQ3vBFuBjOdMgx88oAqnOTQueeCjo3KN9JJnFulP7je/?=
 =?us-ascii?Q?m8M4iBLkv1FKuwihp8z5dMZ9lOCo8+2k+cSdGGtgyxx6becZ6GqLy/+Xvm80?=
 =?us-ascii?Q?TAr3EUREMGShXuC/UGSq9/SsDYlC3+LIbIp6S9oTwepuJTtjuAcj5+jkd2l/?=
 =?us-ascii?Q?/XxIZGDXv1r3WITM+94bnZBnW5ddYUj4vdAPOGC11aDrTU0RCeN2iEvySIsU?=
 =?us-ascii?Q?26MkauvCrsEuhLgCUfBz9LGhQReoedoPtGwhTo7t0Ni8HL6rlUmUS2+dL6QS?=
 =?us-ascii?Q?thkd4bqMxtTH1Jtz9iGozKul1VPnDS+M/JFKfykA+iRowj3uz8/BcruLzY/7?=
 =?us-ascii?Q?3pRDg54YZ5MDIse4DoaYmaYrUDFF5zdR2apeZyB3NaBtXJMBoq5NliPHl116?=
 =?us-ascii?Q?Gqt5rQBtxLY2j7i0t+HedIqaRjOBx+mqNWPdfOLwtyZom7TdzqBt6lt2KR+K?=
 =?us-ascii?Q?c+cxoJi+Od/J94Wk6mpLq/i9yu0KW7gSb0yqDoMCNxBegi3/0XI26EmfAQIM?=
 =?us-ascii?Q?zfDiOTlpMUSjKwFZ4CmQbrLdoHVuG4VOnw2NNOSF8dkGoOOrRguZ0kw3A6Y2?=
 =?us-ascii?Q?V68HQvmz/y/KT3vWe+9xF6Xu5RuWoFrwSSW1yaEyeCFNlYvfvCCNFKWUm1Ks?=
 =?us-ascii?Q?mab1FECjoEnYIz50mxI4POE6KKIaFUXvj6kUM7YdIZ9f81w7fVg8jB64TsvR?=
 =?us-ascii?Q?DjqgqdmVvzY/Wj/Jw796z5bIx9oRiaR5rfDb44b0CSeBwQfYqookzwc0eNIt?=
 =?us-ascii?Q?TqElkzHszVeOrudZrX030CtWfzt/AqeJdJmMZT3LK40x8XUr1Rz+EBsr2uN8?=
 =?us-ascii?Q?gnM9pcvAiyvuIsJBckah1UNesbGVVk40bSlEFQVNbGc01ufIpp8dp0eU3D4i?=
 =?us-ascii?Q?K8yQEQXr63FXP92IP/sI4JK/SLfJObRbghH+LGbFvQxKAFTQglpA6VmUhuSR?=
 =?us-ascii?Q?xjp1Br3mGw/mxqTmfYXNBF3XxO3AyDef7Hs0annrP0V6EydiCVHFUCLTliXt?=
 =?us-ascii?Q?Z8QrF6I00TYzxWNf8UHDSHgjcFYmdSpr/v6EsqNCralgwIOk3Z44ierxLxlK?=
 =?us-ascii?Q?47Gry1P4z2E/w7QLPf15EsXWhdTU2AoDF/aQVcn8JXn7g7JhDuZ11yTDo24T?=
 =?us-ascii?Q?pWtT/KDNNePyRc62yPDZQIATo4OeHwBtfjR1lKEygVOdXWkPXKCXRUv4KRq3?=
 =?us-ascii?Q?FWbLTz74ZEsiEr6iHlGxweY9tFVk5zwn2VNSTI/Z+VwcL5s/GxNhRb2PVimK?=
 =?us-ascii?Q?oeKQL4DWUsAKSv0bAO+DIi2NleWNLKmYPu3WPYTM0rG2iXT+OS2OxYOFZ50H?=
 =?us-ascii?Q?mZFwL6w4hi7nARgvDeCjLqTX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/G9yzChpaXBForib6zYIYWhiaumuR8QDFbxYkRX9bdRaGpHKIqtr+gXjlhB5?=
 =?us-ascii?Q?6XDy2bO9bxkJUZu53iN0qSGZioqVelbU3pucuheO09qJ1C+sPRltN7JnC+Ga?=
 =?us-ascii?Q?q6kHPyFsfcADN4ReEPFvP7NQClQTsZ6GtZg1wGZiYcCVWPYf9FozmppMNMNN?=
 =?us-ascii?Q?BLAOy9GRlufSFmrZBgOWK+qEjUXlAKpff1f69Rs7PjArnp95J90gZ/sQEaA4?=
 =?us-ascii?Q?+ojlHLFTnGjqDfU2P9VL9hA4wPDbhf1wX1fvqkvy1+7uwl83gGI1cQ0RGkb3?=
 =?us-ascii?Q?KzlAnjtfSWqCorisFz5F0dvIGh6Oc7ABFs0KyHcYUMHi3ERzNj018tnxeC0+?=
 =?us-ascii?Q?U4HRBYMwCvifC/aHlCzOByI9mgM2746rGy3hHZW5YggeyZT0+QAiKlIKIP2X?=
 =?us-ascii?Q?OZL5v2ywf4nzCUGJ+IraldjEP4BOJDhATtb4LBxBxu2uAy1LUHYH2yqiFcai?=
 =?us-ascii?Q?3lFpqKpRC4u37RUXMLLCNucBFj+PCw/RV0xHdCd5QvZ4qqyBI65q7ZVRQMZe?=
 =?us-ascii?Q?EqZcc8BnKmBbvSXsy4vPf2GFKw1PYmyYzWHHyV1yLNMyQgdSV7t07wcX1S0k?=
 =?us-ascii?Q?bl6y/adGWm+AJVI68pDS5pIQp6VHwdL2Ou78+ihmv9fLJ867+vV2lchYNpd7?=
 =?us-ascii?Q?gspfC93567oe47i8dUV4kdSVooCb+Q3/JznwCaUMAVpAJDj+T/qGbGVsDdX3?=
 =?us-ascii?Q?9Bg/Zv6NlubpnEQoCLhu6/Pj4Xtj2jWzdY6GXXFqOzEt1PVoyL5r4l1k9Jya?=
 =?us-ascii?Q?ygWPydHhaMznUJBIHpBZ5c5To+FlbJMcg6OeGQzdgVd2B8XnRndkmLF7kk14?=
 =?us-ascii?Q?X/JETkMtQO+w8uqX1q6yA8MQ5JgYWN6ge0Cfd3dek/5+6dsGpQv45RawZXDW?=
 =?us-ascii?Q?deXdS7TgKUXW7568iwasUYe37QRqvymxWd/aay4qtGEly3TD3HcK4DWhVhcP?=
 =?us-ascii?Q?amoFO1rpWDLvm6WN/K3KRC0bc/OMcMmOyi98cP4nTnqqDjxZqPXA/XHg4qtG?=
 =?us-ascii?Q?txUyLFFdkSqX5WUbFwNc38kj/z0i5etRWy166Uvi9/XIHjjvjOLqu5J4WszH?=
 =?us-ascii?Q?Dbo6nPxq4FFNfSbRVTQgl05Ugu/mrpI2MQaEJ/tFmCFrQIZtAtfhYUTcrJex?=
 =?us-ascii?Q?GwoIwxZieAvPEOefKSlH1Kuz4cxVQpO1VscPt066ALhXjiS3NNohLAHaURor?=
 =?us-ascii?Q?i9IVl7ukWU+42/AF7jGjeL9YJOe6mX8rKLFsdUD/eyqrwZkh8an3z/dPG+dA?=
 =?us-ascii?Q?x0jV5BWggoGocyyMwOD+wsHyCW7CmxhWhMkBZ6NeiEPNmM9RySAkYRn+dDYc?=
 =?us-ascii?Q?OKbfqZfHBAXaFFOXHFxRS6UwwPE5QsHr5Sjj3+41du1LdqduaGSfkht26uVS?=
 =?us-ascii?Q?x6ooLXYHeLNROy3XGDFKq7sIcKWs3HLLFdP/q//FMvpi3uNk1IBiIU9YRo6g?=
 =?us-ascii?Q?C7gcUUmQtfj+F0A/NReh+Y+wvsrpcvA8+mYS/M49MJND/AMVLOGH8+yujI+x?=
 =?us-ascii?Q?tXxWnk9mmF44P5+jzuBJKexq5nQfRL7Dn9HnFkR9jfVJ53E7ju9CaPP8VK7K?=
 =?us-ascii?Q?7sR6l1cPoh0mrqo5KDLcc41T9LM5rPJcIczafMAy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a26bbaee-bc5b-4708-9aee-08dc7a65630e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 13:45:05.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8fkkrNh1+VdrGw7Ehb8djFluiYrpjsd5Uqkywt2jWM0L01pgahqUJsy/+UfD7OKKAVR97WLq5IhP6if9ycPlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:

[snip]

>  
> -/*
> - * General Media or DRAM Event Common Fields
> - * - provides common access to phys_addr
> - */
> -struct cxl_event_common {
> -	struct cxl_event_record_hdr hdr;
> -	__le64 phys_addr;
> -} __packed;
> -
>  union cxl_event {
>  	struct cxl_event_generic generic;
>  	struct cxl_event_gen_media gen_media;
>  	struct cxl_event_dram dram;
>  	struct cxl_event_mem_module mem_module;
> -	struct cxl_event_common common;
> +	/* dram & gen_media event header */

I like the comment here.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
