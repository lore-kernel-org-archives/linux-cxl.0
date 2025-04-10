Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E71EFF88;
	Thu, 10 Apr 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308342; cv=fail; b=YgdfrvGZis/X/QhDyjWG70oO45gDw1DZv3HiDbeLJnRrFB4Do6pzb1U51/secSHMjUEI0vQQbDyDQLlPOa/2P3ICoUp1m6gReuXLm58II1VCS/aQkGxg5yQ22Y5KjPrGooV02nC/BLI6uCdeJ36A2A+lIsjU9A//1HSZFBH03NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308342; c=relaxed/simple;
	bh=qtKADkxYdon2q1y2lqHuCrF7AhdtWInJ/XTfBsD/Sx4=;
	h=Subject:From:To:CC:Date:Message-ID:Content-Type:MIME-Version; b=AO5DAXEsw9ejz2LZgb/nZYgZhPr1sr1pJ9zfnHIVtMZgR9hStv+ozHcsYKmUeyn99kSIw94AOzQPfACl76O9r/0nYBDBhlfIu3Fl4oHasbs4/yhLS6tOM9bw2j7casB3OzouwcyMzi3USxxmc5sYxk5PWBF+Gg5NgrAqCGqsBO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f3rm1D83; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f3rm1D83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744308341; x=1775844341;
  h=subject:from:to:cc:date:message-id:
   content-transfer-encoding:mime-version;
  bh=qtKADkxYdon2q1y2lqHuCrF7AhdtWInJ/XTfBsD/Sx4=;
  b=f3rm1D83Effzy2z7GB29zAmg3l2f7bS4xlBparatAMYbvMwlCfDfIE4e
   TBvK0XzuuvhGw4W6q6feMVpai5UzPwRtPgyydefn++YXeg+5iuoo50Qrv
   zyGPVHNb8pK7QcsSIA71Pdvl2aNH+Je/8Yz29H1eb+AYHmUp6+bPIFowP
   JkXhTwTZVC8QpChKlCzzq+UkXvI3GxV3MPMF7rH1sV1RtVBaDaypzOYqN
   toVPhO5kefXVn6CeSq8oGioZtwfiLMAIbDsEWO2S+04EwSE8c5wKtnPwn
   PYi2yTJmZ5+028RnLH86M+5SWFywsYgvfFEIlxep+VmLEUDcrdBSyZsov
   g==;
X-CSE-ConnectionGUID: Y9r/onFjS2WYx/9BE0wD8w==
X-CSE-MsgGUID: +RI+oEyyQmySeOkfByCa7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45939553"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45939553"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:05:40 -0700
X-CSE-ConnectionGUID: PSPPnS2WRl+8nmy0tPvzSw==
X-CSE-MsgGUID: fdbQYq8dSxa54FkH6DMNsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="159950650"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 11:05:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 11:05:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 11:05:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 11:05:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raatDM+dTVmifvJOR2IohetD7dGctwgyhoyBX26X8EIKQ/LAsq/hAEr/92ULKnkBaGI1FsFzixWjdnutv1/CwgixcXRfwKkPMuzBQbxnm+bWQXir4KbOTBfOoReROQpu9AGH8fU/VUA9Pfh+HF6Hwc5/Q0ZfkqerqKi9zhhX8WzCpwk1IfBhl+CiPX2YJYQ2PF3zbnyVAmtACAP3v+x4aaGMi3E1ce3mW7bLz5cBpXS7KEYcpi75G1G8TYFXwq0qLPZSYUl7e6Iji6qsUJxgu/lReAo79IbRjXvMkSLC0JOGVF0LuMYLY85SQ3bZlAInvqrrfCoI52tkuqYk9Euq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3C/0jQhKCX+bMaRzEdD4FJvedbzOMV/q4xNu5xhlms=;
 b=M3gc+gmRsbVHGYwzCOBE2/4AZvtGHlT9Rzi0V1JJhXK/UfPtHNLKYFPnOyZW1Y0V5smEayRedPIlE+IzCj99x4IA+MMUy44OIZeZ6z9EzxkwM7cHx+sA04xkbbwDKPF7LukLz6iDI+dU9mgV7hRZYwTRw8WnCBiFkSw7sESHXI7T/XI5fPt3sPX8yWMFaqDtXahrBxTmOpjFYSyfcKjNCxxbPBkdlCEwRh/GPQOFpT9uJbaWX+lFJn9hWG7hgXmAxWF0vqBiid7g4KTB2umT1PHChAubWYHqZ6KEPrMf+/PslQjrpRnTfykshZ9YghfBF30r0eR/zYlrsMMrGyhLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8010.namprd11.prod.outlook.com (2603:10b6:510:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 18:04:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 18:04:53 +0000
Subject: [PATCH v2] fwctl/cxl: Fix uuid_t usage in uapi
From: Dan Williams <dan.j.williams@intel.com>
To: <jgg@nvidia.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, kernel test robot
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
Date: Thu, 10 Apr 2025 11:04:50 -0700
Message-ID: <174430820360.604341.2116516906072729788.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:303:b5::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: d583b021-59d1-4df9-2e7f-08dd785a31f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzBGT0VQTjh1UVdPdWN6QVJ0cFFNTjUvM1B6d2dIcUV1Z3lOR08rYUMyaWNh?=
 =?utf-8?B?N0t1ZTVXR2FheC9TRjlxV3RaZUhNOHFCSmduaU5VSmpXczIxWVJDcHhoTTVF?=
 =?utf-8?B?S0JEZFJNSGxqZ3F1ZHo3MTFrYWZHOVJzbkFTWWxCN1dXTmdacHVIYkhQZ0Zh?=
 =?utf-8?B?a085dUhYUWlrdnVVcDZOa1ZiNjJPcURRbExQQk5rdjNpUndsb0pmRDluVXFT?=
 =?utf-8?B?UE15enZKSkdTbHRuS0xId25ZVUdkRGRNSUo3VEQvenhRazZYODViOTZmbG9l?=
 =?utf-8?B?bktXTUJLcTJ1MkhwR0l5bHUwRWd4dXlLRjdWdEhaQWhJNmdBZFVoU3VodDBz?=
 =?utf-8?B?alNzSU5lVUJ6MVBzdlhYQ01UTm5RSzdqUmt0ejRpT1F5QVZkU1ExTWd2VzNQ?=
 =?utf-8?B?eThjVytYbDRzbWpxL294cUtyS2dwTW5LKzUvTUZxRDVHYjhncGw2TUIvVkIv?=
 =?utf-8?B?b3F2Y2g5eWxpM2kzS3dLVmxWamszSlQyY1RaVUhONE42aDVlQjdxK2NBNmxK?=
 =?utf-8?B?eDBmUVN6RllpQThmM25WY3l4cHVsUEozZVY5cGRYblpuUzNwSTFyUTViV1Zk?=
 =?utf-8?B?dFNnVGZlbUFTK01VM3VGQzBRbzdsdEFzVHhQZWRRVXhRK3dVUEorRWEyaG5W?=
 =?utf-8?B?N2JyU0pxblU4UVp6N01GY25MYUMxVEovSmttbzBaR3FULy9SL01PcStOM0RD?=
 =?utf-8?B?aGFtZmRGbGxia2cvNlVUZ1dxSzdpWlJXM0JIaGJQbWlUTUJ3bm55QXU4U0U3?=
 =?utf-8?B?Q3hYRlo1WjJvaGlxL0VDdHpqN2tZckRWVEwxOENCV1JhdUxReXViTXR4b2Mw?=
 =?utf-8?B?NmFrQjc5bWZPckJ5WnZJdmNRMlVVNkhkMDRveTlxc1pZK1AvNkVkUjA5TFlI?=
 =?utf-8?B?MnpjSHlsZ25EaTRzZ0ZUNGx6MDY4ZmtuTGFKV0piSENXQVUycVFkdmx1SHRB?=
 =?utf-8?B?akI1MThsMmppNkJoWi9nLzRwNTZmcTRFc3NxVHBQbStLRnRQYzBsVFl6anlw?=
 =?utf-8?B?dVRScU0vbEQrcEZIRlRmWnlHRmtSNWJ1VDNOQzQvZVlGcDlwaUdkUSs3Mm1N?=
 =?utf-8?B?SUdKRk9UMmdhcEQxWFpnaVlBMHg5QUNjR21WdVdlcFlCQ2JIdE1Sa0g4QjNK?=
 =?utf-8?B?RDI1SzNDMTJwNFRmL21heHRyTEdnOTIzT1BTSnpiU2N2YlRIUEtnN0JRTTNQ?=
 =?utf-8?B?dlVLRkRTZXhqZ2dJOWFMVDR6TVFaSlozbFBldEZibi9sbDgwMU51N01JNTBw?=
 =?utf-8?B?TGNpTEZrOWVmRWZWWUVsdHowQUlIVytFWXJTVC9nS2ZoWWVCbXFxV3FSRGNx?=
 =?utf-8?B?Y0x3R3ltY0VpY1NDSnowVDkzK29WZE05UlJoQmdBWnBZNUVxYUs4QWNXNXlh?=
 =?utf-8?B?NXZFQTQwNzdzdmtWa0NLeHlDVzZjazRjeU9lbnJXaWRRdU1pTTBSK2xDOWlm?=
 =?utf-8?B?S0NubkFKMy9abGs2eVRNcFUzRjNwbnNvMzFGMjBTNTF6elQzRHFobmkxb1dH?=
 =?utf-8?B?N2pWMG9lK04vS09aVk93TldyR2xzZ3pPN01JTmp5ZUp2Qm5KTmZVYWdtelBp?=
 =?utf-8?B?ME5LTmRpSFNsNFA5cm5VbHEwaUswL0pkRkEzVSs5QWJGekUxdUN5QmwzRkZu?=
 =?utf-8?B?NTVDem90QUhuRWxJSEMyMW9LT0lDTXlTRmtsN3R2eWdVT2lKVENna09kRFRJ?=
 =?utf-8?B?cFJWTHZYaXlQS1gzeHpYa0ZXMm1hVTQ2V1NKTXRuZzhJWCsvVlJZazg2MTY3?=
 =?utf-8?B?dlNVQXh2ajlOa3ZONytXT0ROMWswNGhvRE0zcURFRVFwTkRyUEMzYk05d3Vv?=
 =?utf-8?B?aHNWbWhvZjFHNHNZUWFpZ0JZTHg4aWlZT3pmTUgyNm0yb0hXTHo5d2FXM3JR?=
 =?utf-8?Q?/VHUgVuUiV8sW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGdMbVE2bFY3N25GMWx4V1lOZVErU0h1bHBnbmx5d1RnMkVJZmphUVlacUVS?=
 =?utf-8?B?aHhOSGR5LzliQWUyZmg3SUdwMUdOUitTNDJhVjlHMnVMYVZHb0hBL3l0cnB5?=
 =?utf-8?B?MnJoZ2FiNjBrOFEzNkpRbm9qYjE5NWFGQzExR2ZIZ1pTbWllR1B1eFlpTWZh?=
 =?utf-8?B?QWplaXZNSDBPL1hoM0hMaTVnRDZjN1B1SEptTkEzNVhqU3o4WG0vVExJQ0N1?=
 =?utf-8?B?QkZlZmowVlJrSDA5SHBuTmp1MFFzV3kyRjgxbzJSZ1pBdy9IOFh3SmNIbjRl?=
 =?utf-8?B?UEJmbjBTRllMRGR4c2xQaytYbDg3ckhnMFF0RVIvQkxhNEpXeHNSbi9GeTl5?=
 =?utf-8?B?ZzNrTFB0d2xWd1lzdDBLUkErRXYxcGo3M1dKZTV5S2FadGgyYllCWmFodjJu?=
 =?utf-8?B?ODkraWVtYUtXZ1pLQmVMTmc0eHJrbmJjV0E5NllndXVCN0ZLQVNpZjFCM0p5?=
 =?utf-8?B?RFF1RE5LUlErZ0hDNk8xT2dzUWhVZWJoMUp2dHlDQ2dYUFloaHZIbCsxZVhY?=
 =?utf-8?B?bHhhL0VSS3VBZkFuOFEzYXRrYndLRFNSS215M0NiYTlvcmo1Q2NRTzkyMmkv?=
 =?utf-8?B?bXAxTnZPVWlteWt6b3NwTHdMVzhzSi8vOEx2bEYzRDJOcnkyMzJHcGd4YTZp?=
 =?utf-8?B?WWJSeHZLMk95Sjl0YktYRnE2b2dxYkNYZmVyanF3SHp3M2NrKzVEbjVJVk5S?=
 =?utf-8?B?bVd3ejhCN3NlRmZIc2h0UjZOakZJV0R5Tm83bG1kaTJMOG5aclR2NVY3dW43?=
 =?utf-8?B?RFBPcWtnZEtMTHBWejJNODl6ZkJJQUNRMGFsdVhuWUNuckpDWStYMmMwR2E0?=
 =?utf-8?B?OUM3VzYySDRqSlNLUmpEeEtySFdodTVHTTFTZ21LK2JXSy9tdWVSa2Q5eU5J?=
 =?utf-8?B?Ly82SVNDcEl0aXhvM0x6S1dOdnVGWmFoWjJxbC90L0NYUGpVcHphdkdSZEFM?=
 =?utf-8?B?YnQvTnJPVWVlYmZMRmRrWXlSTHpWdUQwNGx1SG45STRTNHFHNmUyK3JBSFdn?=
 =?utf-8?B?bEN6ZTNhVldpUFY0cFNiZ2VoL0N1OE40cEd4cUZiOGNRK0Z1Nk1EamZncnNQ?=
 =?utf-8?B?MCtjMWoyZVFzVy9NMzhSVTZqbkQ5WHd4cS9lNW1LbGdSdXllU3BCVnVyVVU5?=
 =?utf-8?B?akQvbW9ydWdRdUtGRldKK0Y0SEFHNDNZbG5yLzlrSHJwVDViYWI1TzZwaXdH?=
 =?utf-8?B?NFlXanFjZGpNS2hjVE9wSHFlVks4N3c1RXpXZTkrMEl2OWRJUTdsOGNNZ0JC?=
 =?utf-8?B?MURkc08vbHg2c2VwTENzT3JOQnAzS1FqckJ2bW9wYndHSkRobXEzQU5SUkc1?=
 =?utf-8?B?UkorZHM2TjR2RktLUEF2cWZuc0E4M0hzNHBSWGc2TWJ3cHFXWSs0czZnaXNs?=
 =?utf-8?B?aEV2a0lDNDM0amN5dFhqa3VMNlNmZWNXR2ZRLzVCU1B1Tld6RHV2Y0R3cGhR?=
 =?utf-8?B?MmpuWjBsTW9xUVhSY1lyZm9qTGxyTVlndGZKMHZKT2MxRGJZd0Y4RXB6UEt6?=
 =?utf-8?B?eHJudSt4aFI5U1hhZzE4WkVJblB3YktXeGsxVTEwalAvMEtXNDBJQ2VBWmhG?=
 =?utf-8?B?TkpnbkREN2I4UVhIaW04am9udCtEWFFOcTRydVZkdXhqQm9WZW1JWHEvTFpz?=
 =?utf-8?B?bWRYRTFyS2x4dEFPUkhCK3dwT2FueVZDU0pGV3Z4OWxjQUZMeUJxbjNKTFRO?=
 =?utf-8?B?WThTa25JWWFwbG5oUkxtd3dyanpCNkxwcVIrREc2YkNPZ0hxRjBVYnpBM2Rr?=
 =?utf-8?B?MXJRZlBPVzVwUk1ld3pFelJLaG9zdUtoVGYvb0EyVE1pV3huZk9uV1hiMU10?=
 =?utf-8?B?Y2JsWEJ1RFV2M2c4ZEFrVGtyRStodkJ1emdjVWJPRWRyQ3dzOHZSTStLTzhy?=
 =?utf-8?B?MjBZUnU4VzJDcU92V0x3TVZjZWhIelozYXlPZ3ZHVGhBcGE1Zk1HVEg4ZjMz?=
 =?utf-8?B?a3lXTHdaTmY5cmpWZ3hKcjVITytkaGZvd1V4WlNGYU5nRmIzQmg2N2xCclVT?=
 =?utf-8?B?dHhjN21qZEJaTEpZZFo0a0ZtZ0FOVWxuMlBSSU5pcGRIeDlXakJCa29TN25Y?=
 =?utf-8?B?cUdOS2tsL0JkT1lYRENzOWZLS3Jzc3UxYmN2WnFvWjhveVp6Z3hvTEUwSGc2?=
 =?utf-8?B?S2xTL0JYdDZDQThGWG01dXpXekk2T1VFTW9KVGloLzZKK1dJZkpSM3FWSzhF?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d583b021-59d1-4df9-2e7f-08dd785a31f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:04:53.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjzW5Qac2KORif61VCFOxrd2LWWFNbKgFHizF6owPs5lc/1R39ZrWj91m52ruGnNu7/zkGD2KFP8FIkiMRwg/zjyp3F5A4sHONue3Sv+/A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8010
X-OriginatorOrg: intel.com

The uuid_t type is kernel internal, and Paul reports the following build
error when it is used in a uapi header:

    usr/include/cxl/features.h:59:9: error: unknown type name ‘uuid_t’

Create a uuid type (__uapi_uuid_t) compatible with the longstanding
definition uuid/uuid.h for userspace builds, and use uuid_t directly for
kernel builds.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Closes: http://lore.kernel.org/f6489337-67c7-48c8-b48a-58603ec15328@paulmck-laptop
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504050434.Eb4vugh5-lkp@intel.com/
Fixes: 9b8e73cdb141 ("cxl: Move cxl feature command structs to user header")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v1 [1]:
* Fix a build robot report for older gcc that has different alignment
  rules for struct wrapped data types (0day kbuild robot)

[1]: http://lore.kernel.org/67eac8df3e217_201f02948d@dwillia2-xfh.jf.intel.com.notmuch

 include/uapi/cxl/features.h |   22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
index d6db8984889f..d0d2d022957d 100644
--- a/include/uapi/cxl/features.h
+++ b/include/uapi/cxl/features.h
@@ -8,10 +8,20 @@
 #define _UAPI_CXL_FEATURES_H_
 
 #include <linux/types.h>
-#ifndef __KERNEL__
-#include <uuid/uuid.h>
-#else
+
+typedef unsigned char __uapi_uuid_t[16];
+
+#ifdef __KERNEL__
 #include <linux/uuid.h>
+/*
+ * Note that gcc-8.5.0 has different alignment rules when the type is
+ * contained in a struct, so wrap the type passed to __align_of__ to
+ * avoid false positive assertions
+ */
+static_assert(sizeof(__uapi_uuid_t) == sizeof(uuid_t) &&
+	      __alignof__(struct { __uapi_uuid_t uuid; }) ==
+	      __alignof__(struct { uuid_t uuid; }));
+#define __uapi_uuid_t uuid_t
 #endif
 
 /*
@@ -60,7 +70,7 @@ struct cxl_mbox_get_sup_feats_in {
  * Get Supported Features Supported Feature Entry
  */
 struct cxl_feat_entry {
-	uuid_t uuid;
+	__uapi_uuid_t uuid;
 	__le16 id;
 	__le16 get_feat_size;
 	__le16 set_feat_size;
@@ -110,7 +120,7 @@ struct cxl_mbox_get_sup_feats_out {
  * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
  */
 struct cxl_mbox_get_feat_in {
-	uuid_t uuid;
+	__uapi_uuid_t uuid;
 	__le16 offset;
 	__le16 count;
 	__u8 selection;
@@ -143,7 +153,7 @@ enum cxl_get_feat_selection {
  */
 struct cxl_mbox_set_feat_in {
 	__struct_group(cxl_mbox_set_feat_hdr, hdr, /* no attrs */,
-		uuid_t uuid;
+		__uapi_uuid_t uuid;
 		__le32 flags;
 		__le16 offset;
 		__u8 version;

