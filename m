Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C98F7D
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770250817; cv=fail; b=NOREdbEE0Jk/EWLKuZw/b4LvcjtUqaCiu0MqMS0q2gIb6U5Dc3msBhquayLWGN6v7ok2gdCa1HFuV0XY6zUpHj61dK8ZN31XXxbaeB1QSSi64NZaAZOMLXz2pk4bkFL7mb8ZRHWC0BLMd4xYYL54XRbYg8PagIIsQwvrwEJnLks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770250817; c=relaxed/simple;
	bh=jOx463kmzFIonXcHVkuD0OoBC/LgL7UnrnEOdPOetxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cxEKLSEFHxUsKnw0kceFyVfCRHFWW8ym7ZkM/QhgJAl/c8oy0ox9veQKjDxQjaRK92psgW9jpVBCYvzcZ9+hXDKvREDP1w6QWzG1/CI8M1QwU5GItesYTtypkQY6MD77segCA9fGaFSvLecMRG10340FQJFzt9VEueTu1jWGab0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dD5i3QHL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dD5i3QHL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770250816; x=1801786816;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jOx463kmzFIonXcHVkuD0OoBC/LgL7UnrnEOdPOetxU=;
  b=dD5i3QHLSHlBuHf7AT4jo35KV07bN2nUlfyD9tXRBiMW1oyr6w3Hc5h8
   VsEu98D5B55YdIOSiZ5a9G1FPno1sJeKhnVpkhqx146vZFmBKCelOiobt
   TJ1ihHlB8ux4s7BhPXQXMWHxmTSqGqde1Ha64VBZoUibC8156c5UN1Gj1
   VygCkXBMYfmBuPGk04d781VLg0S+Ovaac9Gm8UYNEHd8ZPYjNGI/hNtkJ
   hSJXAqVKUxmUZmq+H1/u7SSKSgKTTn87ZGLNz24CsdOUqocYU/49OQJE+
   Rk+JFIoutL2ullf/SNmpqPoBnLldPIQqpfSdVMyx82WkPSwbPLXzJcUGQ
   g==;
X-CSE-ConnectionGUID: bl4f0FnlQCOHCs97pkVtXw==
X-CSE-MsgGUID: vCBHckAUTdiyJmLqOQTzNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82881433"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="82881433"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 16:20:10 -0800
X-CSE-ConnectionGUID: Ihzy/5XnRmaGdoJzgvDlmg==
X-CSE-MsgGUID: mtdM0f1gRy2C2JBowBphsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="247917176"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 16:20:11 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 16:20:10 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 16:20:10 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.11) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 16:20:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsGHz2QF33sa8OfYJEVu7h9xsZHTuE56ykQV0ETt58IjBPsGAUVIcwAr9tdFtyX7w0c/QqV+ldP0Tp0tI6/M2z30lNJGm4JtmSTuJkR2GbeadtvKu6FuxZ9OlZgL5sVZrRiWZcEHyhUMmSg/pskd001cTFTlUzJK1PkCFK+oT5d4uWGQ19UkT6RCe6GVkZuaFnbVdCG9+aw3wlPjNdNNAbQMJDCjVosMftgkXXmLn5mlgyq8z9agv3qP/UYolx9kgEHYLDituwKY8KX5I9EzrWG3HXJeqok7GVh03Ob5SkFsFdMSfwlez+2xO1wbZAcpYXUE7W3FpM6rGeTx0u7w/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hA0klfuQ2HzboJQH8h6W2LrIByxQAHfuxs+SNduxPtI=;
 b=keoV0buBDxI3fz9gx7ECRRL3siVq46l/4ABD4HUS/W/HdAAt05OqJW1jvH99JpUUPGKVAV7a5n/EDgh0RwakZJEBiZwKvA/9QBj1ZhzrEHkH+I5BRg4/0MU04OCpMwH6eqhWEgsTvLrDMU90EY+eYpm+ui3wDMsOtKBDlRCoYFMmmRYjD1WgPtAuvOws6uOiZMdVqwguX5CFm2vjKE7PUI7iBQy5YysefmKpN7PSkE9CFEcU0A3QcxTHruFMMkMqrC+Jj62WMCF+91Twwqq8IMesIgIAbgNDmdXmvc5V6qCAjpNvwWkvz/xm3w3Zd6fDrs6M2d5sqSR9iOduo3a5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 00:20:07 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 00:20:07 +0000
Date: Wed, 4 Feb 2026 16:20:00 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: <gourry@gourry.net>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Message-ID: <aYPiMCuNQ2torvwF@aschofie-mobl2.lan>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
 <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
 <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
 <6981668d2182_55fa10024@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6981668d2182_55fa10024@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: SJ0PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::34) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d81645-6273-4284-6232-08de644c5132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEMyT1FENWxIZFdiZ0FBYm5td3NjaUh1bTZkNEN0ZWNMNVF4Yks3WDk1cmtM?=
 =?utf-8?B?MXlNOFV5TjhFYUoyN3BuNS9EVDFTVC9YK3hIMys3YmUvYnlkdVNxbW54cGRy?=
 =?utf-8?B?QWNiREZIK0hkREw4TkJ4YlNmOWcra0ZFcE5FV0hNUE1uUDVtTkw3aC9jZXNi?=
 =?utf-8?B?dCtmdjRTQnlXSkJkSHRqMWpoVjJEb0NVS0xpd2h0K3hDMW9xWmlPdytwbDJk?=
 =?utf-8?B?WUZqM1dQS3llR0U0aHlSL3NJTkVYZGdjNDRFdXBzSnZWVWIwN2RXMUdNOEI3?=
 =?utf-8?B?ODVsRUNxRXBqSkhFR1dRYkxSV2JtMGlVVWp3ZXR5UzlUcVhZL09mREtsUmxH?=
 =?utf-8?B?OUt0cUYwL1NSOEhiVnJjNENZN2NuZzRtVnd0MmtXT050YWZDZ2QzYVIwalJN?=
 =?utf-8?B?aG52MFVhcnNhem9mZmFlOWJOVmg0RGdDNlBqMXg0OGRSZHBhLzRDckM1dldG?=
 =?utf-8?B?MEh1a3ZyS1MvQngrM0VqdmJrZno5WHZ4eW5UNmVIZFo4ZHJuZ2huVHNiMTgy?=
 =?utf-8?B?bDlMUDlqL1lIVzZoQkRhYWdQUFk1UkI0YzdvNSt3aHF4dmNWYms1eTJDc3Zx?=
 =?utf-8?B?ZEliN1lNQkJraEVHMmZLSEx5T2VZUDNlZHRnNy9oOEREUEJOSkNIL1lGTTBW?=
 =?utf-8?B?N0ZTdG95WWxhS3dxalVuMnZkbTY5dUZBUy9pZ1BIMFMyclJEdWlQZ0wvTjcx?=
 =?utf-8?B?Y25mSVZNQnU2NG5RZFBiTC9ZNlY4bFd0bWEwTjJPaWhUUWxNU1dQaUREMU5n?=
 =?utf-8?B?cTVhcENibk5VemhXMHRFWkQwV0JDeXByQUprejlEQzF0c3gydk5CaXl6NVJ3?=
 =?utf-8?B?RnhwaDF2OU5XVHFYbHFKQW9NNkVJTjF1OW5XUjl0dlgweGJNd25XNm93MG1U?=
 =?utf-8?B?NXd6eUpXUXFITFdjQjU5R2hBRG1MNWhtVUdIdzNKYWZtS2ZzZk5LTlF0NGlG?=
 =?utf-8?B?ZFEwMVg0WENEUkFXQmhyZlFuSStyWmh0d1hoVHgyTW5vdG9wRENTcER6bkM1?=
 =?utf-8?B?ZjNVVkIvN1hMTlIveDRFOW1JK244RGhVVGZ2akhiTVRYeUgvRm91eWM0cnpG?=
 =?utf-8?B?R0ZuK2c0TG1FR25wd1Y2c2V4Tis4N2dvbjVHUEMvSy9KUEZQUFUvMm4wSDhW?=
 =?utf-8?B?UDU2aGRVV1JXU2VSSjY4U29LNExzaC84QnNXaktGU3hqSEtGdFJ0NnVKZmls?=
 =?utf-8?B?aWVKeWl4TDh6bHRJUnVBOFI3TktRdldYUnZUNjl0RlpGWm5PUUIzRUlVQ21p?=
 =?utf-8?B?a3JUT2RWTEdqbDVJd2djQzY3S0FRSkJpZnJ3RHFXQWYzcnhBWXhkeVdqMUZR?=
 =?utf-8?B?WnN4a1FON0o0RFVIQzZ4NkdPakk3Ymw4ZkFzMTRUV0NmQlNMY0tGVHdoV2lG?=
 =?utf-8?B?ZzlxWTNYNk5xTEdwSk1waGYvcytYSkhER1p4VHZOMUlQMm9XckhkWGJNdEdi?=
 =?utf-8?B?YTFxN3hDeVJoMjZZbVRNNHBuKzVjSUdDVE5wMTFCc3FWTkhrblpuaDhEQ0Ji?=
 =?utf-8?B?UHpobTc2V2FzencraE5mcXVZVzBWUXIrQlBodVV2em93UThpTW5teWpIeXdM?=
 =?utf-8?B?Y2wxZnhtQStlUU54QUZsU25vaGRaWkMyNzdXdFdDVFZxK0Jpc3BwdVg1U1Nk?=
 =?utf-8?B?QlVLRVMzYVQveVhyTk9rNkV3bngwSDE1TVB0YTRJaHhLVkhRTEtjOE5SYXEw?=
 =?utf-8?B?cjJqeFlRM0o5WHhJRkdRa2dEdjU4bGVmUUFsQXRrU3ZUdWcxcUsxTXFXUUZY?=
 =?utf-8?B?SHh1S3BOSmV0ZndpaVQ4R3dOSFZaVzdsRFhGUmNnblN1TUdRNlJ0NjJrRlI4?=
 =?utf-8?B?UzRNZ0pkSmlweFU4b05YcVdXWnRjbUswaW9VZmtCdmtlV3FJZGppcDFpY0hi?=
 =?utf-8?B?TlR1NkE2WVA2eC82QitFQzh3ckJ5dmNBQkJKemdDL2VhVGxIalhYem1WNEdq?=
 =?utf-8?B?NFA0ZGFZZ1BxQXI0SlVPc29kbmp6c2FNTStNUUlZbzh2Kys5aGY2dHdOdi9n?=
 =?utf-8?B?MEN3Z3orTFVhWDViMkFLUkJKVU45WG1GeUJ1NGJwWXlwVFBiejBudXJxMkN0?=
 =?utf-8?B?ZnVPanMwZStBaEJmVVRoWDMyOVhLL0lha0FwdWV5bjVic25yQW9qcEtDb3Zw?=
 =?utf-8?Q?Zsys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRicC9lUUduc2g3aU44cXNXU2xkR3dxekxmK2JaUmtCOW1xTHNHcTNJVFNp?=
 =?utf-8?B?K0J6djlSdnZoU25aWm80WStBemk3OVlCakdXNS8xRTRaazMrSmhhTEVVVys0?=
 =?utf-8?B?S2s5bElvdSt1RUZnNXd6ZkxsY2pZOGtENnhhVGNtbTZEYUxSOEQ5VEw5ZHBr?=
 =?utf-8?B?cWViN1dFdnQ4U2N2ck8yMVBHS3R5Q2UzUjV5b0d0M3czdHJZS1Vuc2tLU3N5?=
 =?utf-8?B?WEFQaTEzODVCSjcyc1B2NlpqN29iVXFxMHVwWHdIZkQzUGZoZ1JZblNrSXZW?=
 =?utf-8?B?U3BiQkV2TUtzMEtDQ3ZhdlJPMXBncDFYUmpTcGY1UXF5UFhoWUdjOXNGSWd3?=
 =?utf-8?B?RzlHTFdhenVTNlNTclVrVHdDNDZ3SkcwZW8zNWk5cExOU3ZqcTZKSGdGanFt?=
 =?utf-8?B?TFcySkRISkF4dEY1d1oyd0UzMHBMSk9OTFVFSG5Sd0xqcS9qaW01YXZ1SEpY?=
 =?utf-8?B?NGl4S0docHRsRStUTVNKb0ViQUt3NHRyb0xBM09xbXpXSFpIU1ErTjJrTEZM?=
 =?utf-8?B?V3ZjSlF6YTRoRUlnRUlqR3RTdGFwMGMzY3JnZTlyR3BrNURqQnI3dE9FWk9y?=
 =?utf-8?B?SDdQQXVaemJGdzROYXN6dXpxc1RtenR1Mno5L1NTUWpSZnMvcDRlSmFKUytV?=
 =?utf-8?B?SnFSNUwzcHcxV3Y1b0VNUnl3ZUhtR2tUYmtZZ1E1YnM2S0xsSFkxUmE1dEZv?=
 =?utf-8?B?Wk1mWnphZGZKZHNLdXd3VGVNRU1JeDJHUEtMQ3JZeitMSk5PU0EzSFlhQnhS?=
 =?utf-8?B?eHJzTkUzY0Myd0lDR2psbVdCUVdIcmdxN2JWckRPNXFEV2hueDhzMGhtb2Jo?=
 =?utf-8?B?VzJaYStVVTJyVmNqNjdpMGdPam9KYjcrSjV4RnJEVXlNcG1OcDcxdC9CU2Ns?=
 =?utf-8?B?NFZTWnRFT25FekYwVHdsY3FtWVYvbytZQlAvQk9pL3YxWmRlMGNDMWErMS9C?=
 =?utf-8?B?Q29UZkJPVy9XblgyUTlNSXltNWNBcW55aTdFYUFIcW9JQzZ6dlJ2MUlYL0Jh?=
 =?utf-8?B?VlYwSG1HbHhwbnJyMldCeEVGSjBrdTdkTVNJYjJPelkwM1MzQy9Ock5oL25m?=
 =?utf-8?B?OEoySlZMSlFBWVFSS29KNmdtOFhMYVlFVEpqYU0reW5RUGdIT0F6ZDB1ZzhC?=
 =?utf-8?B?MDNydEd4aWFEaTBBYkQ3MXlYdWFlbFlkaWhFT0lpclNnQTdpUFJDY0MzVDlV?=
 =?utf-8?B?SStqZHZmcVQ4YURaRER5YjdmbVBuckFFY0hFVjNaaUphcUlNOUZJdXlPUFhp?=
 =?utf-8?B?dmN1bXU5SXYwU01jSUsxY3lPeE9ZZDRkVFdjRW52bHpXZGVEeXF6R09wbGcv?=
 =?utf-8?B?YTk0SUNHNFpXSW1nL2NGZmNwMzdWZUhqMEVNdER2LzB4MDg5eE90aDZoWXpI?=
 =?utf-8?B?UnIxY0dlRk1zRHp2MmhKdnFLOEN0S1cybTVTcXB1bmxtd0Uvdy9tVmJaN25v?=
 =?utf-8?B?ZzlkTW1rYnZVVG1GMlBhTndNcFMrcHVkOWp2Q2tpZ0RhTGF1Y3ozaTVtaEFG?=
 =?utf-8?B?UnBBS2ZicnptaWdHRFk4V0VpRTlIQWJJcCtaU3M5cDc3YXFyZUxFWE9mZHFR?=
 =?utf-8?B?dTRCMlVja3hLcW9NbEdXMHR0QVIwNVpHTVFGVzFRU2QxYThaTUZXcmhweVd1?=
 =?utf-8?B?MzI0OXNadE5CbzZOeXZLN2RUYVVXYzN3anhJMzBjZVRWMGVyaFlqc2x6clFy?=
 =?utf-8?B?aHVsL0F6d0Z4bnp3QkJsVHdleE0xeWd6Y0t5N20zbnM2OW9qdXR4b0VoRzRj?=
 =?utf-8?B?S1R2ME4rQlVxdjFsZzgyMTBkRi9OL1lFNmRpU1BMeUQ2VkJpaVlTY3FSVFNn?=
 =?utf-8?B?Z04wd2h3TUR4ZUkzaXEvK2t5U2ZZWHRtYVlqa1FteTBMcGNlaU9PaXB6SUky?=
 =?utf-8?B?OUlBL2x1L0xHek9hOXBVMjR1Z0R0N2oxVWpYUG0wQzVZTE5YNDEzazhRa3Va?=
 =?utf-8?B?WUEreFRVT002bEFuUXVXOFY1TUFONDhwK1F2UDZZRmo0SzYrR2RDMW1HbmlG?=
 =?utf-8?B?Smx2Vzd0WmI0VnNwVHNMbFRtNEVoZG5PVkNaNjROZWwyWDFNM1Y4RHdiOCtI?=
 =?utf-8?B?VVdqS0ludnIzRU9BUFlvUzZvQUduSEdwaXB1LzgrdTVUNEVBSEtjdW0wV2NC?=
 =?utf-8?B?cCszNFg0ZHZZOWpQNHZOZ1RnbEJtYVkrYWxQWUpzQlpjQ3F3T2VnTy8yNi9O?=
 =?utf-8?B?RUxuMFg1K003TWdodnJyTGtWN3F0OE14WUcrODdXcmxsb2RjN0doVUgxeVhO?=
 =?utf-8?B?WWRTRHBZUU1hdzdITS80c0pwSXlUbElOOGNLalBuVFhxanBFWkVXQlZ3QU5i?=
 =?utf-8?B?cERVblJJQW5VRUIrK0F5SklldGFxS3B6N3RwN3BzcXRYVWJUbGtlaytJM0hZ?=
 =?utf-8?Q?R/sVeB7VeYvF1AY8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d81645-6273-4284-6232-08de644c5132
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 00:20:07.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sNN0sesCqXwe9WK6sktikFICsGa/5wryvtgMWvtY+Q2cBXk20AyImEHInpZZ2nn4R3w4ctQGB8Uso6qHJ9otVWmO7RSTQH8EHhbQwPQJxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com

On Mon, Feb 02, 2026 at 07:07:57PM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > On Fri, Jan 30, 2026 at 09:45:29AM -0800, Dan Williams wrote:
> > > Alison Schofield wrote:
> > > > When auto-created region assembly fails the region remains registered
> > > > but disabled.
> > > 
> > > Right, that is good forensics, administrator action is needed to figure
> > > out what to do next.
> > > 
> > > > The region continues to reserve its memory resource, preventing DAX
> > > > from registering the memory.
> > > 
> > > I would rather have the partially assemebled region to continue to
> > > exist. It can help debug the expected catastrophic error reports from
> > > DAX enabling access to a memory range that the CXL side can see has
> > > completely failed (lost an interleave member). If the failure is more
> > > benign and DAX side access is viable, then the forensics matter and
> > > userspace can cleanup.
> > 
> > Thanks for all the feedback, Dan & Greg -
> > 
> > I'm responding here because this is the overriding topic of do we want to
> > behave better upon region assembly failures. If there is a path here to
> > becoming a better region driver then I'll take a look at the implementation
> > comments, like if or how to timeout.
> > 
> > One point I should have led with: while we are focused on failover to DAX,
> > the issue here is more general. It is about the region driver leaving behind
> > an unrecoverable partial configuration on assembly failure, independent of
> > consumers.
> 
> This gets to the heart of the question of what practical problem is
> being solved with this and is the solution suitable? Outside of the
> "platform is doing something strange" case like "Normalized Addressing"
> or "Non-CXL Interleave Target" I am struggling to imagine an end user
> benefiting from this automatic cleanup. A system which is so flaky that
> it can not arrange for BIOS configured interleave to stay alive through
> Linux boot. At that point I expect the end user to decommission that
> system, and flag it for remediation, not recover it and keep running.

Hi Dan,

Why is the response different here that with DAX failover due to wonky
BIOS usage of Soft Reserved resources. When BIOS is unclear(?), we give
up on the CXL regions and give all the memory directly to DAX so the
system can come up w all it's expected resources, yet for these region
assembly failures we are willing to strand memory, even though the
option to give to DAX is so easily available.

In the past, we've seen BIOS-defined regions that the kernel was unable
to assemble for reasons other than outright hardware failure. While we
can hope the worst of those issues are behind us, the region assembly
code path has not been quiet, so assuming no more issues seems ill-
fated.

> 
> > Neither of these failures are recoverable from userspace today. If they
> > should be recoverable from userspace, prove me wrong, but I'm doubtful
> > that we are just one smart admin or one good cxl-cli update away from handling
> > this in userspace.
> 
> That is my bad. I mixed some unverified wishes in with my replies, but
> the end goal for me remains the same. Userspace should be able to undo
> every step that auto-region assembly performs.

I haven't heard that before. Sounds good to do. (Repeating myself
I know, but that'll take a coordinated effort, ie changes to both
region driver and userspace.

> 
> > That's why these patches make the region driver fail gracefully. And I
> > do think it is the region driver’s job to fail gracefully.
> 
> This where you lose me. It fails gracefully today. It stops in a safe
> configuration same as if userspace stopped short of fully configuring a
> region. I keep coming back to the RAID example because CXL region
> assembly is roughly patterned after RAID assembly. In that example a
> RAID0 array does not disappear after 30 seconds if auto-assembly fails,
> it waits for administrator action.
> 

This is where you lose me. An unrepairable config may be safe but it's use
is limited.

wrt the RAID analogy: I’m not familiar with md internals. IIUC RAID tooling
provides supported admin actions to stop, tear-down, and rebuild incomplete
arrays. This CXL failure mode leaves a partial configuration that userspace
cannot repair. So leaving the object behind is not comparable without a
supported repair path. Aspirational, but not within reach like this
soln.

> The potential conflict with a DAX takeover is a separate problem that
> also might not need full teardown if we can make it work with
> incremental fixes.

This is intended to work with and is tested w the DAX takeover patches.
Like said above, it seems odd to let DAX takeover if BIOS gives us wonky
Soft Reserved boundaries, but we won't let DAX takeover for region
assembly failures.

> 
> > When auto-created region assembly fails, the region remains registered
> > with decoders still enabled. In that state, userspace does not have a
> > supported way to unwind the configuration. cxl destroy-region fails because
> > the decoders are still enabled (--force fails). So while “administrator action
> > is needed” is true in principle, the admin has no effective action available.
> > Leaving the region behind does not provide a viable recovery path because
> > it leaves all the things related to this region stuck. All the things being
> > the HPA resource, the DPA resources, and the decoders.
> 
> Right, I think that is a gap worth fixing to have all the same tools
> available for partial creation recovery available to partial assembly
> recovery. A "gap" and not a "bug" because only a unit test might care
> about this presently.

This is not a unit test driven issue. It was not found in unit testing and
is not motivated by trying to make a contrived unit test pass. This was
observed in real configurations where BIOS-defined regions failed to
assemble and memory was not recoverable. 

Agree to call it a gap. Did I call it a bug? I'm not reading any intent into
why the region was not unregistered upon assembly failure previously. If you
tell me that it was with the intent that user space tooling would pick up the
pieces, I believe you and it's worth examining:

Which will work better:
-- improve the existing stop on assembly failure so userspace can repair
-- or unregistering completely with a fail-over to DAX. Non DAX users can
   recreate at cmdline.

It's difficult not to be biased towards these patches, when they are simple
and within reach and the other is aspirational.

> 
> > On the forensics point, the most actionable diagnostic information is not in
> > cxl-list output. cxl-list can show the existence of a disabled region, but
> > it does not show why assembly failed, which endpoint is missing, or what
> > happened at the time of failure.
> 
> cxl list -RDi -r $region
> 
> ...shows the region, the number of expected targets, and the ones that
> have arrived.
> 
> > The forensic info is in the kernel log, because that’s where the
> > assembly failure is detected and where the relevant context exists.
> > With the changes here, the kernel messaging is improved so that the
> > failure is explicit rather than requiring the admin to infer the
> > situation from a disabled region in cxl-list.
> 
> The kernel log does not know the device that was meant to arrive.  . The
> kernel log likely has debug disabled by default. This situation should
> be debuggable without the kernel log.
> 
> Likely the first notification of something wrong is operations tooling
> noticing that serverX came up with less memory than expected, not a
> kernel log message.

(feels out of order here, but to finish response on comments)
I agree the cxl list output is useful, but not as useful as making the
failure explicit in a non-debug kernel log message, nor as useful
as giving the user their expected memory via failover to DAX, nor as
useful as allowing the user to create a new region from userspace 
with same resources.


--Alison


