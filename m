Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2C2332916;
	Wed, 14 Jan 2026 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414704; cv=fail; b=cIhvnAJIt8dWD1aR7A3SuGwbouDaBnQgOiCSX627DeahgRdyqlD7E8EIVHyd4wbmODeHiet8Mxl7YhUjsLlNxI3gOZHXQEIqfvmVcsU8nNyosZWYDwLmSXN32HYhqS77jXR32AMam23vb8+GX3xf3Renzaxga6vD9sRkomexWYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414704; c=relaxed/simple;
	bh=zsm1sCqY0NkXQOzV041+ypmZcgm4Q1SqnLzuzEynlYE=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=mqf5C2AKGb8LFl9dcGQKiGYMkf/3QD1WLsUKJaiF2I4aBex2xvUIX37IfSF7skOqF2Xq4TMmOP+Z/FREtAv1Nz90OOWr7qaQp/uHSxpDcb8q+gsRgsrAF171T8QsBegZymmvEjiG/SksrsUHnCAAyfN73Max1ymhMUzFdveyxNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBNqdBbG; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBNqdBbG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768414703; x=1799950703;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=zsm1sCqY0NkXQOzV041+ypmZcgm4Q1SqnLzuzEynlYE=;
  b=KBNqdBbG02dfgWsBgdEDHT2ktNxG7//f30MiEuHoxZiXyn1WJAjywzMM
   PueS68CULuqoWzNSYD89XzTYVw2UP07EId+fW4/kwjt8qwqImEaSHLops
   QUeJbJ4rHX+OWYuXmi7qGPYJMY+EkdibZ0x+jjHZkvYH+PqhCkIEHLiZ7
   +DscGRqHVMQ4DJY+A+P5zrLUifSC3QyeFP2C/v1EMhXgIXBzrZmyWFmyQ
   hliEQ/un3iOd5NmUT3P2Ih1+nNg6J3wDA0KI6SjADLMRTSncF0tW1bMlt
   LZfso44EYaxDU4zZglhhx78qN83sG9BJ5s93EwNhqtzVi1yheQzynNBDZ
   g==;
X-CSE-ConnectionGUID: vuk33WVrQ9C9cIbF9zVINA==
X-CSE-MsgGUID: KcB283k+T76ZPGRLCv1I6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69773702"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69773702"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:18:19 -0800
X-CSE-ConnectionGUID: Si4bKLP0Q7WCQIdkWZG7Yg==
X-CSE-MsgGUID: /g+RSJGLRp++NsuhXBZseQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209793901"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 10:18:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 10:18:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 10:18:19 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.19) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 10:18:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIPGBzA60q7WMA6pZhj7Ti4/kQmZk5YUnofZHaNl09xhf4Vsk/R4oQhS+VQ1PDl6K7OZXy17iSTnn0OKScqy+b0HvYTLo2dTsVZAvUkbeoqbvjLS6r3XghNAavwfGe92t5ncoXk14XCPWQoQ6bGwuXAEP5gArX5s995Skgtg6sAZnL6UQ8Z+PmPVmE+Lv/STjLG/feXDuPgQp7x0/+Px45ohe5LWVRuSqp2a9NgYFamshXj/VpxsgaC8TrXdZ1fPpNNPwfArNgHk29edBiciIJ151D1MLp+GWiyAJyWcgcFXKv1nSIpzu9C4sNgCs0Auor8LVT4uYFBxY/COeehOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwOg0TrIl0cDHcwCyud5kUU1RxLdjfskTK7148riHTk=;
 b=aAygvNs9wxEz6kQqLZQssEKgFoikP6JbNZZCTs6ai94ICRN5d5Qu0OcmEsfXXM5MiJ7xkMl9HrcBIjSGDIuIMTzUHLILCZI5D2vxQb4HCWaRWylKYAtGRMnj3W5dJxy1LiJksQPqkiU1v5/76slJ3VW/1srG34py3QdRmoUs7vTsZtsoPtobFyJ8Oqnm8ZxSi4p5wSGGITngv6AYIwArmgXh1XaV+NRBN1CQQe/vLFrUR/v7iAB3LOZymTTRxdpNJlXgJXaRpGAfdOBcQSHU48n3Wl9Di85mB1US8tut/rY/vf1KbpI18sxWB1jWWGPHSoGmJEfPnhdqzso13gKn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 18:18:17 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 18:18:16 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 14 Jan 2026 10:18:15 -0800
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Corbet
	<corbet@lwn.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>,
	<linux-doc@vger.kernel.org>
Message-ID: <6967dde735474_34d2a1009b@dwillia2-mobl4.notmuch>
In-Reply-To: <20260112111707.794526-3-rrichter@amd.com>
References: <20260112111707.794526-1-rrichter@amd.com>
 <20260112111707.794526-3-rrichter@amd.com>
Subject: Re: [PATCH v3 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f244b4-cfbf-4089-e028-08de539949d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1IvQm1pN0FjN2Q2bXVBeUdCdStUMGxuMnpzc3c1cGtaSTZnVFJRc28xdWhI?=
 =?utf-8?B?ZFdid2poeiticnNmRGxoS2JJZjFOV3RPVzR1R2I1UUVoS2FScWVNM2tFMnA3?=
 =?utf-8?B?aWIrNm1kS1hIL0Mzc1crVmszS0k3MS9Pa2J3aGFGR3laQ2tvYmpCU09VeWVM?=
 =?utf-8?B?S3Q2RGZ6TFdGRXVyZ0U4dzUvTmpNc1FnU2dyMnhFMVp0Znh6WW8rWDRBNkpV?=
 =?utf-8?B?SzBOdlNmL2ZoK3ZjelBiMDVId3F4c1NoNzZPRjVOUE1GSGhHME5MN1ZJdkht?=
 =?utf-8?B?NndxdFVzMnBNOEhVcEtXbG1vTGdsMUFwSW9sZnVZRnJJTG45N0dNZGY4WDVp?=
 =?utf-8?B?OGVSblNMdEZwUE91TFJDRzVXVHpqVGUvSGdkOHhhdTNLQy80c2VhVGM2UmtG?=
 =?utf-8?B?U1NFc1ZSWndEbnV4TXc1UGhOZGlBNDE0b0NKVXcwOUVKWW1QRVNaTVdIV041?=
 =?utf-8?B?cmo1dWNLcS9MUmEwNWIvTURGenJrd3lvdmZ1V0tDOWZneFFHQURiSlZiS2xN?=
 =?utf-8?B?ckVrc1RadXFSUFhabEIwbnlSU2hkUE1aOThkRW40bncybWxCbUJJM3FiMGZL?=
 =?utf-8?B?Ymg1bE1aNjk5eXlPMW52YTRUZDg3YSt4bGxmZkd1NWpDbW1TM0J5SVAyUVlr?=
 =?utf-8?B?YnhUQnJNWldlYTh6N2R4b09xRzhDTFNBdUNBVnROWHhLWjcvZkcvc09FRjk5?=
 =?utf-8?B?NjhEMEpFTjhlVkVXRDFtK3VWMUhNRVNVRExvZlpWWDgzV3h5SklrcW1kMGFh?=
 =?utf-8?B?cDF0clUyUHAwR3V0N3ZCNmZhRXVXMjhVM2dKS2IrSk5nbDJQakhMRTBDaGdS?=
 =?utf-8?B?dTV0M3o2WHJub1NKeE9ISWlVZEMrek00eFprR2NkWkdxV3FEN2lrdXlsbWxk?=
 =?utf-8?B?R2VhZmNRdVkrbi82TnFLQWVTWlpseHZIUlBFWDN2Mzlpem1GMVFXRnNrQ3dN?=
 =?utf-8?B?SklFVzV0KytsRTIrQ2xubjMzbjBJQ2ZyNFJyOUZmS3F4OE1ZZTVjS0djaVlV?=
 =?utf-8?B?L1I4VXlVcHllN0V4TnpCSk1ISFFId1Z0NS94cUhzOCsxSU9hTHc5cTZpVWwx?=
 =?utf-8?B?RnB1Y1hzdjZGNFFMNmVJRngzcVEyQ1RQdHJraURlM0RFY1VLUDVUeDVlclVi?=
 =?utf-8?B?ZHd5L1pITVliN3g5aGVwMlJ0cStNUVlSZUFGNTFXTVJSTmJYWXNBc01RYmh6?=
 =?utf-8?B?aWRnYjBPUCs0ZFRuNityQ1BpdEJKaVlnNkhLa2tpaVlpMmRIeFdYZ2txWVNi?=
 =?utf-8?B?YWhyOEVWQkVLVUFvQ2ZlMFE5MGZ1SGZSOXE4Sk96YTNKbE9pUmhUWEgyUGlR?=
 =?utf-8?B?ZDVDQ24xZVFsRTlIN0s2RXlMWHhuWnJPTHV0eFFSSElIK1Faa1lEMkxpN3ky?=
 =?utf-8?B?NXh4dFMrRjU5SGp2MUVob2R0MHIyTlFKYUo1b2QyQjFlOHJnN0lZMXZMQ1ky?=
 =?utf-8?B?U1hXODJUcDVkNFJzRXVTTCt4Qm9TMThZYlJvTFVUbW5RV2Z5UC9oM1ZTbWV2?=
 =?utf-8?B?cnEweXpGZTVEYU9UR3VKV3NCMUxvS1VIUnVsdDY4ekRXYTdqbFYraFZ1M0Ru?=
 =?utf-8?B?d3hUdjE2L2l5TFZlZmF3TjhlVUVoTFI1VUxuUlpZcmVKUEUyTzBtYzhoZENh?=
 =?utf-8?B?OE1ETGFhTnI4Z0grTkN0R1l4YzJVRzZMVkZERS9raTVpMG9CNjhQUHlsZXlX?=
 =?utf-8?B?eXBIOVl5cGZqNVFYR0YyQ2dRRHBHU3p1Y1hmUW5zSzE5UFl4UExOUUFVdHhy?=
 =?utf-8?B?S25UOUFPdU93YjRjbWZ1eWNiVHBBYkx3WFpyS1pjS1F2THM2WGlnK3VBS1FH?=
 =?utf-8?B?Q0p0aUNwVkJwU3JlUFN2S1ZJekQydTFyM0xCZndYRFZhYTNmblIzTTl6QmpQ?=
 =?utf-8?B?b0VpRlZYZWVwZENDc2FUMHdsOUZzdGVkR2o4ZWZBdVlnRWd1UkFaNlFkYjg4?=
 =?utf-8?B?UHk5K3IvUU5EL0x5MkRZNngzY0p6Wk1IbGFwUERlZm5EZVNmK20vSTZDMStP?=
 =?utf-8?B?SlBOMjNrazFnMGowbm0yN3hFazJIVGU0cUJtejd5elZJNEZoWjNZM2c2dWI0?=
 =?utf-8?B?bVFmem1ab0d3aHM5RTdpQVpvWlFqd0pkUGlWTGN1OHBHRk95M1N1MEVDbzM0?=
 =?utf-8?Q?wtS9MFPVvBXKp2SDvzuOAHX/V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGVEekprc0ZvcVNWT0VHOUJ2d3NFVVJjQW1aTXFEUDNuK3FsWnQ4Qzh5SVhP?=
 =?utf-8?B?Qmd0SWxCYnJJcXNwdVhRSmQ2cUl0RU5kVkJnbWJ2d3IzUTFmMkF6ellYT3JT?=
 =?utf-8?B?QzBnTUxFK0NTRTBvRkZPN3YrU2xxNDdQRml5M0hJOHdGa1M4U2NqRWY1TjJF?=
 =?utf-8?B?R2VtVkVuNnNXRWZjUndRRWJtWU1NTGkzRzkwK3ozelVXYU0wQWQ3a3h6Ujlu?=
 =?utf-8?B?YWJrYWM1b2ZydC9URE5ML2x6QzdwSG5UcUpqUkxaaThEQlJ1Mkx0ejRFWEVQ?=
 =?utf-8?B?b3U2TU80QThDcnhUQ0xraWRpNlgzMWNkMGZrZWpZMG40N2orSDkwS281MzhJ?=
 =?utf-8?B?UzVrR1g5RCs3clo2SUFBY1lHK3JPSEpqR1RkV01GWlBHYmtuNTlBOEF5WHM0?=
 =?utf-8?B?QmNuQkYvK2hwQ2VlN282Q2RybW9nS1ZHaXBtajVJWGV4Y0YvWVBubGlvVXNu?=
 =?utf-8?B?djJlY1NPTmgxdmIxY2NJaXFraUVScGorcmhLM3pwWnpsMjJFUFdJa1pXSDJT?=
 =?utf-8?B?RW5laVF0ZVJyOUI3N3k3QkVFWnVUeHBSZjZzRVo2OXE1RlVpcWx3Uisyc0xo?=
 =?utf-8?B?VzJMVE9YWjNOSDJhTU9kQUZrckVJQ29sOWdVRXNBbXZlcStjZFFlcnlVUFJs?=
 =?utf-8?B?ODkzNkpiMXIreUZJdG5xMDhEb2NjeU13ditpMkJYTEFKS2E3TlFWczdsQllB?=
 =?utf-8?B?ajdoaXZ0ZGoyd2JlTFoyNjVFZVNRYmZqVUpqWlNzRlAzN0NCeW8wL1BDa2xj?=
 =?utf-8?B?cFBpTDI1TTVpNXBaa1UzNFVDYWdBN0NReVhWVUVqV1F0M0Eyd0RVbXpJUFJh?=
 =?utf-8?B?dDA2YU11dk0rZkduaktpZDdoOWhhV29Qa1lCU1h4MndTblU1SUJmYk1ubUsx?=
 =?utf-8?B?Wk5kVWZGMktvK2drUEZldHk5ZWhMK1AvbWVEQ3RId1crK2JNL2w4dGtHaUV6?=
 =?utf-8?B?TGs5SXRibFBVY3VweWhKZ1RrSEdNdjliVW5hT3hEWEp4dktlQmQ3NlI4dHdQ?=
 =?utf-8?B?MUxTS0NTQmMxenVXbTJHNTBoTFBhR05rVlVCSGxDVVAyMTU4RzdvREN6clRu?=
 =?utf-8?B?WnQwdVNBM1FFVTNnc3NROWx1aWhEeVVSNytsL0w2WXJPQjJOcFBhODd0QkFE?=
 =?utf-8?B?eEQyemdNeFRuaVlYdjdBeUJBOXdncXNGNVYwajBrTzNCTndta1FnVlEvWVFR?=
 =?utf-8?B?OGJSYmdybDdvRGwra2VIa2JjQ0ZnNHBMZ21lMXRaVmJYb1dhbkVEOXhJU1Ri?=
 =?utf-8?B?MVdTclN4QjdiZjgwTkVFeUdnaXNBSXp6dEJubGtOby94a2ZGN3lkTEhHQS9m?=
 =?utf-8?B?Ynh5UFltQUNoZVFiZmtxL0xPOXdaaUl2Y0FkTkdOYmZTdFNLYlI4dThjSmlu?=
 =?utf-8?B?WngxbUgxTjI2Rzh0bWwwcXpab1UraVRtN3B6QS84N2FoeUk1Mkt1aHBvYjVu?=
 =?utf-8?B?ekZ6aGRwdGYwMmFYTTcrc3pxcW9keFhFL2FSMVRxMEpJZDdSazF6WDJZa2I5?=
 =?utf-8?B?cXdlQnJFMDVPcWVSNUl5ZnR3RGVlQVhWWlNRNDNrVlNkaUMyQmdRR3VmVXdk?=
 =?utf-8?B?QVl1WUQ4alVURW5OWk9QV011YVpxWlVmWXFBWENmSUNMWHRydlRYR05kTEJL?=
 =?utf-8?B?a1c3Y3ZUV3lFTURzTTB2Z3JjZlpOVEtiNDQ5dWYrUXVDVFRvN0doYUY4NVEy?=
 =?utf-8?B?YUM1dXQyaGZrUlE1T1VMbXBROGt2MW5iVENTd3ZaeEdxeTduUWhzK2c2dGt3?=
 =?utf-8?B?YVlnbUlyUlByUE5yb3VzR0hXbEhWUUx2N1p1YkxUWm5vS3NBUXB0b2pORzlj?=
 =?utf-8?B?SnptSGRJbzIzaWZvUkQyS1hwdzVXSDVKMTRnbzcvOHg5WVJhRUFlZlNObEl2?=
 =?utf-8?B?S1pFNDJpbWRYSnBtVHlUcWRQZkV2NUM1dE9SYXNnNEVJN1VkU1JmWm5xYjFH?=
 =?utf-8?B?SkF5aXkwRUJrNnhHaDIvS044dVNuNGsvaFFsNmNpVUhtbDR5UXI3N0JpcEQx?=
 =?utf-8?B?YVMrbDhNLzlnK0NRd1FkVStwRE94L0ZyMFYvd3RYeFBpc1Jvc01JQTRSQkwr?=
 =?utf-8?B?WDkvY01jQ1RWVFM4eHZXczVWeWJ0TkZXMkMxYzlWY0xHRkhQSTdCRWVyVzJ5?=
 =?utf-8?B?Y29ac25CeDExRVZ2V0tvT2VNY2QzMzFmeml1VmVQOUJtVFNzK3pxckVDNHI5?=
 =?utf-8?B?K1VwK3hLcHUrT0Zwa25NQ1liSjAwazdoZHc5cWRUNnB3Y3U3K0JkZ2F4YjM5?=
 =?utf-8?B?SEVUdzRjS1ZSajl0ZHNYQVdFWmlpeGs5eStZZE9PRmxNSVlSMjhBNzNPQW5V?=
 =?utf-8?B?NGJzb1REakN3Tkt1b2lIdUZId2h5MFU4cFhRWHpRMG5SR1FYMXBmd0ZIR2Jl?=
 =?utf-8?Q?QfKkb5SAPbnu+Zm0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f244b4-cfbf-4089-e028-08de539949d8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:18:16.9011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jd8tRpNyt6gE/U8gVja4VwG6NKTlYg9XqvBfTQ3SDPpvkzbsDGIMouOxodqA9mGgry6a8X8AwibAvfXr1VXTUt4x7NlDNGIKHBWEDoBxyhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
X-OriginatorOrg: intel.com

Robert Richter wrote:
> This adds a convention document for the following patch series:
> 
>  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> 
> Version 7 and later:
> 
>  https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> 
> Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v3:
>  * updated link in descriptions and add Link: tag (Jonathan Cameron),
>  * clarified CFMWS and HPA range description (Jonathan Cameron),
>  * use 80 chars line limit (Jonathan Cameron),
>  * added block diagram to illustrate the example address mappings (Dave),
> v2:
>  * updated sob-chain,
>  * spell fix in patch description (Randy),
>  * made small changes as suggested by Randy,
>  * Removed include:: <isonum.txt> line (Jon).
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  Documentation/driver-api/cxl/conventions.rst  |   1 +
>  .../driver-api/cxl/conventions/cxl-atl.rst    | 205 ++++++++++++++++++
>  2 files changed, 206 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index 9267a697b2fe..0d2e07279ad9 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
[..]
> +Detailed Description of the Change
> +----------------------------------
> +
> +Add the following paragraph in 8.2.4.20 CXL HDM Decoder Capability Structure of
> +the specification [#cxl-spec-3.2]_ to the end:
> +
> +"A device may use a different HPA space that is not common to other components
> +of the host domain. The platform is responsible for address translation when
> +crossing HPA spaces. The OSPM must determine the interleaving configuration and
> +perform address translation to HPA ranges of the HDM decoders as needed. The
> +translation mechanism is host-specific and implementation dependent."

Thanks for this Robert. The only comment I would is to include the GUID
and calling convention details in this documentation proposal. I.e. make
it a common definition / generic concept such that someone else could
conceivably reuse the same GUID.

I.e. AMD is just the first user of "Normalized address mode", and this
contribution is defined for reuse outside of Zen5. Not that I expect
anyone else *would* use this, but I do not see how anyone could write an
implementation from the above limited addition to the CXL specification.

So extend the existing ACPI method calls in the spec beyong CXL _OSC and
and ACPI0017 QoS-class _DSM, to include this new _DSM definition.

With that detail fixed up you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>
