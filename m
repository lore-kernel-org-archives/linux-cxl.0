Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC192D5937;
	Wed, 14 Jan 2026 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360833; cv=fail; b=UumNJNJggVmgvGkoDRkGmeVvKs3rNS2pAJ7ZtKLrWeUOgGbF0qnu/Rgr9QiGUjmKF8EDvdHDJuzvL03HxtzxAAR3XTC7OJstVs0APvg6mkZDvHH5hhYnuvETQWbE94Dn6YzURpvDVOSc+WTCv4nOkNoVGQkzSxi9fJrU58UyjDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360833; c=relaxed/simple;
	bh=xer8RhGocB0ae7nvPFhjMaTxrtEJwMTjjMaTMrJ4jpI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SO7Qn+G9SRICHOmYOpujxB6Zproj/I4l42r4vCMh5rL8CIE/9bxuRG9n5Wo6nnIaxvYSzWTLoDMRC8At87e72KBLjJ8TsvWPw1U3Njyq3Xh/wmNcuZj1mOv3jK4eZCrJJFMQJQpr81QuMmxkXVUXd4ZH52njkEPDaJLxz9ofxp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xh8aGkeb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xh8aGkeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768360832; x=1799896832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xer8RhGocB0ae7nvPFhjMaTxrtEJwMTjjMaTMrJ4jpI=;
  b=Xh8aGkebgYztBpD2aEaN2w4vHSEbWE4UPLfDhAf9jUK/fSElhjFRNv/z
   QyCyTJ3jx1h4RovThj3m19HS79WqJhYCLg03u7Aj/hx29Zsa3tihjyNg1
   bB+fVIhNqhoX2vOiTUU1fxamElRJiUez/nODhZCwIOa7zIAzNjx5vtI2o
   TUZAc1b8RMsO0dV8fwj345+gA5WDbANLLYUI05TQNMhiq4sweR1pOkTq7
   bp7sGwY9oNsnWdPWAnUW4i0BxrvN7XbpTWUGQjykV7Dg9a+LUApPHmaLv
   aAEEeZ2zrHP9ycAp3f3MKFQ4BgQjo9TB/WRysktoHI3Rspq6tqkwidNMS
   g==;
X-CSE-ConnectionGUID: N07wK7gtS0aa9pI6vnTP8g==
X-CSE-MsgGUID: 3ByzHMtpQyS/gMxgRQ1JHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87238794"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="87238794"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:20:32 -0800
X-CSE-ConnectionGUID: wyUi4gpbRQG7LtRucs1y2A==
X-CSE-MsgGUID: EzPdazToTXi56qLns0XENA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204194678"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 19:20:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:20:09 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 13 Jan 2026 19:20:09 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 13 Jan 2026 19:20:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PG6COmo08kz4aRekD+jy7STzUlkK/6TuXKYY+Xav6YmUMPor+DLi2NbYXcaAtXZQqg5yN/iO5owdN9xqUtOvDkjGEeGReNT/g/ec4ODJz6YLGDzwPveQI9WeW+klgBjiHXd+qchQDLkkMltsxfhL2cv9UEhuqxPl6BM9esQE+owfyZXkHy8xeEOU6ZyLimtktE1IfqU10OLDhVuFixhwEcvgYjwd4kr+hNHwjg7lVInrAZk2AYdfH5mEWACrgw7JVyLiBsh2oXVrnaGCUC6taeKhcUp/S+Sq1C1g4weqm2gZBYNu1DBA1sDCiz/KSCTBo/E7/1Ae14jLYWat82XXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ht6uAlNxzyLHlzG4c6yd7p+B6dSmtfOi6qyglfmBMCw=;
 b=ASKiOlx4tVd+aAaoH2onXA2uliMQzqJbi7xPpttLxLZrzajoy5x/C/uYurgI+TXqbZMV+x/C4IrpL6tA7LnPyLBHbU4BbZN1GUII0CczyN9Jn6EgSjlHlJrH5SRXCsuKSN2Idrdq3uISjw7vq9pYrwXKmX1dQSxdIWNHDEZ9vNe0rKqLvRxlTFTgxzeykWUhRV1QaO5aH/OgbWHKkK2rAuK+zGTID9l/6CFlFXSQtQ6rm51t79VK7/Or8Snh7CuyIwGNFyMqvq0UFwU+GWhXNe0mmxYPkgV9vm/Ks2rplbkvxzkXv3uMC5f7htk5kBlavwXJzxGYiLwLeVGRGjkXrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by PH0PR11MB7166.namprd11.prod.outlook.com
 (2603:10b6:510:1e9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 03:20:07 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::28b8:802:3fb0:4bdc%6]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 03:20:07 +0000
Date: Tue, 13 Jan 2026 19:20:04 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 08/13] cxl: Introduce callback for HPA address ranges
 translation
Message-ID: <aWcLZM0qSBvK7V2v@aschofie-mobl2.lan>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-9-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260110114705.681676-9-rrichter@amd.com>
X-ClientProxiedBy: BY5PR16CA0014.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::27) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f60929a-4281-45a9-2a4c-08de531bd157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z7JVnIm7B4JsVc7dpuRo2RUFHjRmiHI5JqXD9/MShe6Ue+5D2mUPMXs7wp/m?=
 =?us-ascii?Q?8o1R+Dqk3NL+6b5EKT70VWfLLm6g4sYh0lOxDJIJfj2LSmjPzpFB49pfzW0S?=
 =?us-ascii?Q?qXcLYgL8VrEyDSEccnH4p0RkfwyERQXLG5s81+ecyS2+/vQXJnTt9ocdDHUW?=
 =?us-ascii?Q?5Jqy9jFuLWAjSXhxH6+rFRzVTTSIQiSJcxFmTSQkJtNcOczPj5PV+so6r+Fm?=
 =?us-ascii?Q?BX6W9EopbJ0Of63irMQlZ9aE182/611ZFZ02AK8cQz9HLBmoLtiXqP27rYSC?=
 =?us-ascii?Q?H8voQVNLhDfh4kXiMPEcO0a4Ziy0YEAopUB5P3KvAfTUIOpMfsPidZh+ynMu?=
 =?us-ascii?Q?3FUXraG4lynKhF9V0vcteZbrTga4hhhjqujoJyBCEJMKi37pGGd2dQQm2FLd?=
 =?us-ascii?Q?lHz5RWVWC5plZxd3aOHem9INzxfHPhovgI/3afGs3/1I/TFQyLc8gRn56InD?=
 =?us-ascii?Q?qEtK8FDxVYHtXzSR4pU+NcKbotid2Dhedbn85L+FQ2j0hlk8buD1ooP7Jspv?=
 =?us-ascii?Q?Xq/XgcUJ9pDhQCEmvoQrfnPxLWA7uiOKrxcKG4uzbwJfO7zTQ2wFWxudClzP?=
 =?us-ascii?Q?sH7XcRybnfA7YhV/aGnSH3DMJGQ5F9ich6wT3FI/k8tKBN0RzwaOU9t8dQ2k?=
 =?us-ascii?Q?tB1QeuuCeHoc3ycbmPfTMFz0yG8h3D/1+b7YsQS/y9Hq7NYBQT7VhE6ZMG0A?=
 =?us-ascii?Q?FzQDg1GjXxT/lZBVueoykq/CwYQSl8sVIPVzQAeQ78iO+KJWAeC74RNjsRcg?=
 =?us-ascii?Q?X9wSPwxY4ykxZaFZJL9QhJq4/CGbwHAoIBKCMRv4p7pD0ORsv3l+wNfJedya?=
 =?us-ascii?Q?0cGlYt1AHvW2C1IP0RZplJW/fBOA48yStcaYqz+iFcs2j+7xDN8CKcMpPiH2?=
 =?us-ascii?Q?uz9nLAPiF9zwV1Y57ru+aHU2yvN+izZiCWD0YcGSKFyBKWsfTKfzwTUrki1q?=
 =?us-ascii?Q?DUlEfrW9IvJO6+uzFLQmUCjegy7bh8bKA+K7hdZAazk7Ig6mtNNwZ7QQta87?=
 =?us-ascii?Q?iyBP1fT31TdehjdypJNVvreLmanuujUDAQugvn13GFSByqvwrkE1Ko7bbuaM?=
 =?us-ascii?Q?IVXFmreJQj1+3xgGVctX+ZS7K+kfalxFj4XBl3cd2xYaRT7QnltmWWi1SNAv?=
 =?us-ascii?Q?py74DnEJUvaFuLuO4+9QNMiLGnDdOWy7/HDfDeM99H6D06YXR2aDRRE4bXQY?=
 =?us-ascii?Q?Qo6m/bMCKPPWCLgHdP93MWZFICBAh36QgKabEKYYCqXi8hAuA73hZCVQUE2L?=
 =?us-ascii?Q?t6IOBpJ+JtGEkJFq5e03LXedt6aEnDzcKA/QVBz2Z9NVyxiHmeOThZBCCDkF?=
 =?us-ascii?Q?eSHdeFYZviVdaDcMeEbXLj2FKPrhtS59jD9+ezVRm/OtZ+ngZvmZ8YFv+Abd?=
 =?us-ascii?Q?HR1bZFLgACUX6AO0MrvV4ScyFF2+cpKYOUokLWRF5XeOmHHcEBUSjfuSA7Ku?=
 =?us-ascii?Q?UH5D5G0VWWtfF/7trWCH5w6hQd8b7WhE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rK+FOw0RgBvM9+T8mnES4NDqSpi8n75XVvTYLlDrMxJGWp7P9O7KPP1Pgeqn?=
 =?us-ascii?Q?8tu+Qe3uh+1wRfUduoLgO9lRfL10PI5cNnGuYkhCfHWCC63Ndx9xC2AsWTkh?=
 =?us-ascii?Q?Def4dPLviORndHEeC1FiwZnupF7T5MhFLVNdy+hPnWdXPXJJQiYNoPRzYNBy?=
 =?us-ascii?Q?LQHQe2GQklk0WuB8nbPkAj8b27leEIdD3K6sYNm5TBIBrsFT2Lhkf+c5F5Ou?=
 =?us-ascii?Q?QlbyraEtcO5/hh5SEY82lgaFRmzMeKHPNG+oz8IeL3RS+/KwJA2ft328tCyK?=
 =?us-ascii?Q?mW9Tict1xAwcCWwq29SRwnJgJchpqoemUFrUQ9j/QMZ1mZtRQi854Gokchyk?=
 =?us-ascii?Q?F7a7D7NNdnC3cXVDUlKrCJB+IcDLOjm/jthwe626uEhFlQfV/rn3Z2uRZ5C9?=
 =?us-ascii?Q?UDaTMLlXZtTipCUWg2SSvWmzSbOkTBICRdEZaNGOzv+fHqPGqRodAFp7iEBJ?=
 =?us-ascii?Q?q1GJ2WtaDfNQcn5HZ7DE1nLELB8ivDYp4UullenBVtjLgUooiHeIJHFKb/Q5?=
 =?us-ascii?Q?X0HcLwkC/VGKeFORsIPa8EyzgAQFNnssoILWEx6kjqPLQmS0Y1tecIn4gjey?=
 =?us-ascii?Q?QjzHwRDvRPrU4Yej+nyMQ3aaM6iq8KxMKkBIy0gkyBz4YyE0jZ2j6BfH8IBQ?=
 =?us-ascii?Q?qwlnrFrRYISp58v4YwpOonXBLCgH40xbB9mP8Z6EMjb+Gi3bvy/Xngzyz+iN?=
 =?us-ascii?Q?7tBcRYlrTcDA81OYls0z3Tl5lAXJ7eeDUQ3etGYFbJ8ETQaMg/D8xaLvIxFt?=
 =?us-ascii?Q?q6K5mGwlDFuKWSb5Os7oz3zQdUbCfkfolctTbSTHJwTZr7Cci+BRo28oOSEv?=
 =?us-ascii?Q?M7vh/tx85zqT55TpOabekJ7p45XRMF42qbZki5FTrmC+lUvVOWnhlVGxNl2j?=
 =?us-ascii?Q?tlqN3m7Or1GBjfsz65V2FpDpm7oH3PmKb2UuhIAbk2xOU1anbij0Gq6FLlDN?=
 =?us-ascii?Q?+jln7UnH6SFl+MCEtUpqlwo6g9qInDTJIqj9xLZ4OYTrM22NlNV7UYmKt+Qr?=
 =?us-ascii?Q?oWmiiuM92L9lWJ6haxEcCnyxO9A+Jh4lsezdfGYsK7plnW8/j1eCuQn30FBc?=
 =?us-ascii?Q?KI7V5wiE6qbP/V5xCs4yxey1dpjoQYlclAagCZpsgt7RALOErAfJI7+WbFy2?=
 =?us-ascii?Q?ES0j4fUqx8pOnec4rPx1cpXpMSGHW/Eqj/vGvp7rhk5CP3TP7IlQLiJLZdUH?=
 =?us-ascii?Q?VH9TwYc/R+I362zXzeIkPGwUIOSeQb0d5JBibFAwPR3CEjWxHaNQoP4y31E4?=
 =?us-ascii?Q?ahgM81DEXVdwMdNIHyVVXrTa3M9a/m/tZb1vWoRLqZscNbhHARrGLBbQ2Bj1?=
 =?us-ascii?Q?RXr43toGPgX/xLotGOBl1cEhCIA9ShSWnjvK7s1D0ASwrLv5be+/qqiWu9bo?=
 =?us-ascii?Q?O5pF3Uud5ej9Z0mHjkS2ChTSSu9SGwigv3RN30AAo4UP8ju8eAuBLUzWcjos?=
 =?us-ascii?Q?U+FDuGEwn1HqzHq/MGhVx2PGgmtx9br3tyRp5L2Oi0AXVcgM/qNVEQ2Eb+kx?=
 =?us-ascii?Q?CkYhO4IW9sPueNaWOJjLeyZXRjPypLHePXNptMKMWTDyg1Q2hoYN0Ajsb0tk?=
 =?us-ascii?Q?q2qEJfEimxj3D//gvygTijBOtwvs8Vosd/v0ay43i2zLaBCyR8QQiHe0uYga?=
 =?us-ascii?Q?Kx/EBahMmAnk2V28IzAtnURoYSmPxbbO78txhynvxIc+62R5LTyN6rjSVWIP?=
 =?us-ascii?Q?oH8q304KtMioTTOFhrbXYYtr+M0X/sD0BN3rpeIKsd8oQzy1BGbgtTJLJlFm?=
 =?us-ascii?Q?3vqqkVxhIjNtJ3u6kiFJrpKUp36aTSc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f60929a-4281-45a9-2a4c-08de531bd157
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 03:20:07.6742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xEXhuHK8yP+u9WmB9hbJERwfqsza1hv5X7zXE/CnQZkPsIqIF1uK1JfXbUrRLLQuZRIFmSMl54y+n+Eb+AbF8+t2DPQE/OWA2avUSoAUnNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-OriginatorOrg: intel.com

On Sat, Jan 10, 2026 at 12:46:53PM +0100, Robert Richter wrote:
> Introduce a callback to translate an endpoint's HPA range to the
> address range of the root port which is the System Physical Address
> (SPA) range used by a region. The callback can be set if a platform
> needs to handle address translation.
> 
> The callback is attached to the root port. An endpoint's root port can
> easily be determined in the PCI hierarchy without any CXL specific
> knowledge. This allows the early use of address translation for CXL
> enumeration. Address translation is esp. needed for the detection of
> the root decoders. Thus, the callback is embedded in struct
> cxl_root_ops instead of struct cxl_rd_ops.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

