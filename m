Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB913B8D7F;
	Fri,  5 Dec 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969008; cv=fail; b=BVWhqumcP3sk1AwIyKN0KpvYMSePobSsFvAeXvjO07llXFX0aISCquwIia5nsPlahMs06Cfn2IGnjFOhHJMVZUh4Ep/wZVmO6phAPEvPTVRZjYZJ9DFYNrj8yZNAMrvyltDnjEKtVBJKSsw7VOsFaM1jgpwF7EO01JNe9j4ouMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969008; c=relaxed/simple;
	bh=+QY3+UwDn5y9u3HkOINaGwG2To5oqD2II+4dnZAHACk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=W0wbDSn/SI8FnbJ4Ye+7iOwe/qZ6yFB8DY01+/pxYqcRLWuz/k7D3lL2CQK4mWLMfb6zTKrlP7XNQ7qLnCuKHqbOxe1+w5Kv4aYKY7wyRZwFZzgoEwcd0fWgyvD4ZtVW8fJmF1Qgfichpi7dtrd+IqdGMzhAZbYP4h6CXoC5ZxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zhkxzw2x; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zhkxzw2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764969007; x=1796505007;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=+QY3+UwDn5y9u3HkOINaGwG2To5oqD2II+4dnZAHACk=;
  b=Zhkxzw2xn2Gkt1Fp4K8l6/ymoZfjEvqHkR5dflURcRp9dSljytliZugL
   oLovawutuw7L0i5DchQK6XqMoYTgNKQnfaipFgBIa/ydWCpESg4xUGX9s
   G60U7QkaC+e6sp3PEQUyCbenBQmrMWO0ReHpj9kC5WkUTDf60h6L/IxMM
   Heq8kmnEWTOvVEcvTKVCu0qFPvDr5PrL4Y4Ph+lrwTAt8Q+kN589yVT62
   n82XTwZPJyKweS6+sSmGMTbZz3LzsBLDf+nwPKvUs3/EJej1A+03qO3qq
   6WGFSElrzOKEdAi1Qj4kh9Jx2CSd+i6t78pp8b5YonpgDauCD7e9skpnu
   g==;
X-CSE-ConnectionGUID: QsRO9l2uRbW2AnvKV/lirw==
X-CSE-MsgGUID: fSUPupzFSj6JSiiKFnaxdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="70858967"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="70858967"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:10:07 -0800
X-CSE-ConnectionGUID: 5x9wlcg7SkOdJNSkrPRMBQ==
X-CSE-MsgGUID: 4K/dOCTeTOykF8poC/yaQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="218737000"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:10:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:10:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 5 Dec 2025 13:10:05 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.53)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 5 Dec 2025 13:10:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3DBq+hkduj7CrCyDgGHn51r/ubHDseuIcXxzllZV7zEbQdSsHzC9nZ9i32zw26wxC575hni+t0vM4AbVZQc3ufLc4+maAnLj5umtiz98auz5vy8tKL07j7uv03aEsT3e11POxlYdVlIgCbwLxIIYB0BlwgadnrGVBZICGOm4GBzhKymkF5QGpoZBWgdatvXaMJxO7vVkEi1bfW8Gi2MFWUjZ/QZ3JyZjDYwY4xpvvT4qmaGqYaP5klR2XMaxMkzCqfPR05yppnl5JWk+2v9vCe2RqlRc4KJpWgX3msV5m53jLpfM/q5SmUs2OPSjDi7xH57HOZkUEjtjyP7AZapjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=097Jl2ywvmYwvsHE2fneDf4WL4wIScM9wBQF0RRdHBU=;
 b=yvEkpkikpNKj5cjvB+YGFvbrU2+IMvG9vj+9A6FFAqvAqnYb6dtqHg9Dxjuxgr39dCsDDF/bBdVHapUyRnZoQZYKvXkl9tc+nUnhQCe59iDAbL8YfY5JYllUb2/NWOkb9dNuQ5R1Rpzq9OnVlGwgxRl3ppQsYG9ehGTxAEjXwt7x9CqD7Pm48h6vcz+Ya4QjOj+LHRTDUhoXJUBw4h3KpJQA3N2WxS9sJgrxzu75/DLXLk+VjYfcMb9Q+/Hc9sL6qEp59jVdmdZR44ZHk1qZOmv2glC8zag0/CF4/lqKwz5GMp2ro3ipDcWP7cwvjsRk54oSXetALL4w+Op/D3vMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:09:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 21:09:58 +0000
From: <dan.j.williams@intel.com>
Date: Fri, 5 Dec 2025 13:09:56 -0800
To: Swarag V S <swaragvs09@gmail.com>, <dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Swarag V S <swaragvs09@gmail.com>
Message-ID: <69334a247157b_1b2e100e7@dwillia2-mobl4.notmuch>
In-Reply-To: <20251205195524.2454-1-swaragvs09@gmail.com>
References: <20251205195524.2454-1-swaragvs09@gmail.com>
Subject: Re: [PATCH] cxl/pci: Fixed typo in Kconfig help text
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4433fc-6234-4dba-86bc-08de3442a557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?US84ZGtrYXBVOEdySE14Mms0TDlKNjh2d3UxM1p5Tk8zcjM0b3RsU05DWFlt?=
 =?utf-8?B?MVI1VlFaYVRxNGRKV2xiYVpSZHFUQmc4cjlSZ3dTaVdhVE5xMFFRdmtzSlZi?=
 =?utf-8?B?TWdScnp3MUF0TDJBUUJkN3lTT3BGUE1TZXZaRmNUM29XTHZGbG52U3RlS0I0?=
 =?utf-8?B?NWpSV29YdlI1ZFVqQlBWSU9ZZzF4VDlxYWEvYkR1bjRyMmtheEpoWGJkaU9O?=
 =?utf-8?B?VWwrdUxuM2xvVXJDZUVOQU9aejFuOUtLZ1dtRmJkTlhMSVJ1Umk4UWNSQXdC?=
 =?utf-8?B?dGVkL1Z1OEIvcURHK2VpL09kWUlNNnoySzc4cDBiWGcwdzc0bGdVN1RWMGUy?=
 =?utf-8?B?K1VSeXFxSTdYS0I5NXVnYTRvMlpMTU9JNmtWdHFZczk5YkhyMVE5Tm84b3Yv?=
 =?utf-8?B?TnFZK2I3dWo3UlFsMVg4b0V0N2NOYzdkdnkwS3lGMGV3Uk9vYjQyMWlKaWtw?=
 =?utf-8?B?YTlMaVRpNHEzTklQQ1VqVmIvUnNadzdhRnowRXRLVS93Wm85WnpaVktrVTVI?=
 =?utf-8?B?NzVwWXNDWlJaQmdGWUU3c0RvdmI0NVl2YThURGd3eVBiaXN3L21oR3NrYWlL?=
 =?utf-8?B?MjBrV2pHSHJnQUFSRjlsdmMzdEFuSEd0b3RxN2lwYysrTzBRSGhQdmdEd0kw?=
 =?utf-8?B?bWZsZEZ2cWlzYVoyNDNNK0pNWFBqalo4dmsxb3A4aThuRWhmdm9hbnlFQWJP?=
 =?utf-8?B?MytENit6dWE2L0tuakczeHVUZ3NLbnIrRHZEUzRDS3VmSlBHSW9Wb3ZLTTJx?=
 =?utf-8?B?VGJjWnJJTFFUVG1zUHA3U2hBM3gyU2hmUisvQ2VaL1hQWGk4Z3dHTE1QR3kv?=
 =?utf-8?B?QXFqczQ0VW4vQjcva3RVSlV2aC9MZlFkTVB4b20ySVVEVEhoZlMzTzRhVGpo?=
 =?utf-8?B?UmtnNDlpcG5iWTdXYXVIbVNKWlVMWnByZWRWZDUrbytkNXhhbFZiWTR6UEpz?=
 =?utf-8?B?ZmhqVmdNTDRGcUhaM3FML3lVVXJPdUFmeGpnZkdaTm5tMnpsWUptWURWUnVK?=
 =?utf-8?B?LzNuc2RTMWs5aW4yMm9xd3YxTjZ2TDYwTnJKSktpRWxUTkV5am4yb09aQjZ6?=
 =?utf-8?B?ajZiZXU3cmVUME56Y3lwR1NyK2VvQk81N2pTMDRuOG0zSFk3cDdXbDVRRFVX?=
 =?utf-8?B?MENkbFJEYmhaZy9idGFpNHRZZGNReVB1SUtFVlV4ZHh0QVhINTY0RWdGVkh4?=
 =?utf-8?B?U3VkTUdLajI0bE1oT2FWQzlrZFdoaHUydjloOEQ4NE0rRFE1a2dORXpXa1lV?=
 =?utf-8?B?SzVCOFJFUTVJWnRxNVZnU1dqWWUxeXY5Z2UvWG94MUR5clZjY3o2cUFQMTE2?=
 =?utf-8?B?dXg5N25jckUrU0JpcXpoeDc1b3IzcEFpeGFrYWFIRCtIVWdpVEx0KytHSTRn?=
 =?utf-8?B?cnhmMlZJTndNdHdrMlA1aTQ2WXVTOWVlemNHQTgvL3k3emQ0aHRwQ2I3dFRz?=
 =?utf-8?B?ZkhGdGw5NjhaT09hUTNWNWEwRVl6LzE4UXBZSDB0ZE93TWpuMW5rbEowNmNp?=
 =?utf-8?B?aSttSHM0M04reEVsWXFtRjVvSXVyU3Y4SVpyS050Y0JaemFYOGd6SUdXWlFx?=
 =?utf-8?B?eTI5aXRxem50RG0rU1V2MHYwN1lXRmhtaEJBL0dQMEYxZk1VZFZWbWNhdXl0?=
 =?utf-8?B?dXp3V3FTL2lSUWhoU1FMd3ZHUy9saUkyQnVuTXN5TkJhOWJ0bUtnaEROWFVF?=
 =?utf-8?B?a2xheE9xemZ1cmFQdW9QM0hieXdmb1plRU53UURKVmMyUCtEV1lsQzBBcXdF?=
 =?utf-8?B?VXRHbjBtYkI3WmFrandpNnd6MjRtUE9JTnJDSFVDY2JSNmxjSmgxcXUwWGNk?=
 =?utf-8?B?VW5FNWVQQ20yMTRJZ2k2UnNaTXdrYnE1U21DY3dZVzJURCtlTWhBd0lTbU5V?=
 =?utf-8?B?Z3ZlanUyRGFIOHNQVG1EaS92VXdZeUNublovVTlMWmF1MmlhRDBLaVM3T0o3?=
 =?utf-8?Q?Ueeg2ggDdhyUQYk5muHSX3hLoIm0ca2G?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXQyK0JiZ0hrK2JBaHBEV0ZJUk1QWEZlYXRFVkd2N2JQWmFGTExUbEMzS242?=
 =?utf-8?B?SGFEMVJvUmMvaVBrUVFPTEJjL1hDY2tJSHdTdUdjUm5UQzd0alZiaFREYS9t?=
 =?utf-8?B?c2lKZWR4aXhFdmNSTms0c2wxdi84VjdvNEkvRkFRdWZrZjVjVlFzTjBseTFw?=
 =?utf-8?B?eU1OekRxSkJ4YTc3OTJQbXlMc3Y1UVB1QXUyRGM2T09VaVdBN3NtWHJBRGNv?=
 =?utf-8?B?VHYzZFo2RDhmUFFyZjgvN3JUOGJSc1VFK1hQVkNYdEZkMmFZYUQ3S2JqYng5?=
 =?utf-8?B?dVROb2ozSXRyL0Z1dmZ5SHZvTmZocElySHdjT1U2dDVucXlHbXNRQWZZcHpE?=
 =?utf-8?B?bEJ5Z1hBZlI3bzlURDZ0U0dCS2tkQ1lOdUlTUFIrZUpUZmxQUjFCRTdvRXYw?=
 =?utf-8?B?YUUrOUFUbFVvalBnK3Y0TVZYRmpHK0dZTW4yMk91VGkvSDdmcEdjbWEzY1pi?=
 =?utf-8?B?SEdMSGhCdW44NHRaNHQrMThUeTR5Umc5ZzFlay9wLzJWM3RnK3BSS0xxeUh5?=
 =?utf-8?B?N1dBakVJV3BtMGhVRWdzdjUwSzhsNnlOTER4eE5YZ1RFQ0xBY2svQUpqdWFE?=
 =?utf-8?B?S1JrNUh3QzlHU3pNN2RySytxTVNrQ2pCdUhsRUxQNzZYWlVTb2tTWDRHWU1S?=
 =?utf-8?B?djAyVG9QbWFYQVRjUndEeWYxNHFLSDdjdFZqN1hLU0pQVkRRdUNhYURmall4?=
 =?utf-8?B?WEE0ZUFHSGxRN1kxT3gzVFhBRG5IOUJhMkxMRHJlUE1WUWQxNjRrMEE3aG83?=
 =?utf-8?B?bXVsS1dIbEpEaXZHbnFEc1JxTkIrc0VwdVlXd3Urek5EbnBCNy82c1FIVE1L?=
 =?utf-8?B?bllKT3VZaDRpVDhsSWlsN1l3elRwNEtndWVaY2ZBNS8wMER1MnFYYVBMNHN0?=
 =?utf-8?B?NDF3cHl3TkJsLzNhUGxNWCtYZWE3UkFwSzMyT2s1aW9DRGdPMjViUXFiNXhu?=
 =?utf-8?B?dm1PZU9ESnpZNjI2QmVvY2g0d0M3OGErVG9FWmlvQTRvQ2o0a0xCbytWQU1F?=
 =?utf-8?B?eVpmOGt4QklYMlRhclFaams5UTJXM2lBbXVsMDdKV0xMWjQxNi8wcnBISWQz?=
 =?utf-8?B?U1k4MEhLc1c1cTl5NkNYZVBYMnY3dEM1V1FDcGNvUUVlTTkzTFpKUmk5cUM5?=
 =?utf-8?B?Y2VJeVBNS0lKcmg5NmRPdkVUSHFldjZaaHdiLzlTV285b21lc3pWaDVkL1Zq?=
 =?utf-8?B?OURxeGRRWlUyWmFwbkJySHdsaUpoZjEzcml5LzV0alRtckFLVE9nMFE0K2Jr?=
 =?utf-8?B?RXdMTjVuUGwrc3BRV09aZnUyK2VnT2ZpSFdmdFFxeUNseE5IQjlYZGxZUnBK?=
 =?utf-8?B?dFNmUVRSS3VQalRkVmNseE1saG1pdC9nM2pBdXN2VTZzWmtLSFNjd0V3WHF2?=
 =?utf-8?B?MkRZQVNiTHNSRWZPWGlQNVJLWk1MeEV4WnFxL1V1VE1HZ1I1Yk1WMXNURlQr?=
 =?utf-8?B?NEliWDFnSXNSeGhGTmlsMllGR1pUcTFNOXNlWnV0OWZSWG85LzhCY0M3TDFy?=
 =?utf-8?B?MEV2MlJHbXljcC9JQ2hHVDlXaC85T29vcVZWODh3NStnQmZDK2hYQVZ6UkZR?=
 =?utf-8?B?UEdoREJCOTF6dkhHNXNBR2pjMk03NDJyZEhvS2tjdzd2Ly83NFNMcklFS20z?=
 =?utf-8?B?Q3E3Q3RYclk4QnZkTXEyUGF0Z3VHemo0TE16MFFCdy9iWm9GUHhLM3Y4RzRZ?=
 =?utf-8?B?RzA1RXRUTEd0Y3JQekE5bmJhOW5tN1UyaG9QZ1ZaWWpRUmR6S1ljWC9BRHZS?=
 =?utf-8?B?SS8wYTNvdWN3d1FMVTM5SnpFazQ2NVhWRzNpMlJLakFEdy9MWkd6L1JUN09Z?=
 =?utf-8?B?Y0xCcjdWTW4yMmNqNHYyM2xzZ3BmaG5xUWZOdEV3RUNzWXVndFQ0QmNEWk5u?=
 =?utf-8?B?b1A4clFUL0ZUSlNacUd2N1o5QjJpUXd1SXIxbUxJL1M3eU9hUnZDWHpYL2sv?=
 =?utf-8?B?K3hmSXZtdDhteGdEODljWTdTV213emtHSGc0dXVkRWVVTkVtcU5mZ01vWEgy?=
 =?utf-8?B?TXlJdzhjUGUvbFc2N2hBWmVoaVIxOVB6VEIvampvSDFXdGc4TEF1R1E2Vkk3?=
 =?utf-8?B?TEtFbHFCeFdkQ2NTRnJYd01JUk55Rys4MHFFbWVIS3lCaDdCT2N0VG1xbFhU?=
 =?utf-8?B?VVZJQXlvUVBaYzFGVEFtOFF4Q1dzZXhUekdnVjBrbTI3eXN5OHBwUHpwR3Fn?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4433fc-6234-4dba-86bc-08de3442a557
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:09:58.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJxlP+nKV0YVnl3dfbbAUtHelTVHMi4b414dVi+aDt1QkEQblYvnGWUPrURM5qTo+WlYweLp6XQ0v+geYIbISSB9QSYxnMaAyaLlY5Mh+sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6207
X-OriginatorOrg: intel.com

Swarag V S wrote:
> The help text for CXL_PCI incorrectly uses 'Device's' (possessive)
> 
> instead of 'Devices' (plural). Fixed the grammar.
> 
> Signed-off-by: Swarag V S <swaragvs09@gmail.com>
> ---
> Hi Dan and CXL team,
> This is a small grammar fix for the CXL Kconfig and my first open source contribution.
> Found this small grammar typo while reading the documentation for my seminar>
> Hope it helps!

Hey, looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Congrats on the first Linux patch!
