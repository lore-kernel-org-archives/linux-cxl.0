Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE02EC553;
	Sat,  7 Feb 2026 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770485317; cv=fail; b=DQeNEa+23s+CzwGxj2OVhz/+pBgT8/tJURw7cxS5cJRriNfzb8C//1jF3aVVzowqp6oIu/POSLEpFr54BxhzQNqH7ZYAkQQcv0y5Ceg3Mx78RRtvHlO6SFbge0RIhWdD5kdKVGffjtEVB1/0TBchAVY1iSNeq7Z7t3N43TRMJOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770485317; c=relaxed/simple;
	bh=hrls8tqpRQgLPMe4WG5XC/uiqRQw/FpCHNNLFfxIIKY=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=l3toE/fpBNS6crxAtQpL+OaRHZvqcBiZEBBnYZUGFo7vrlLj4YMtmuD8oc/TitT1/EUf67cS5pcqm2rqgR8zp+VAULZfLeozEANEn1OrWTsRxy/+dk9vbH78KnRJMhEixP5/BFmy99q8fnFw+9iDPKa3PbveOzflC7mOlzCzXWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfSK7rwp; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfSK7rwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770485318; x=1802021318;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=hrls8tqpRQgLPMe4WG5XC/uiqRQw/FpCHNNLFfxIIKY=;
  b=BfSK7rwp3f1b0uZbIsTR7qL6wA4G8Hc8SinjMRw7fbXubXIWckg2/F77
   n7wVvFAxzyJ7OrO2f3O+woPyDzXJyo0fMJCV6ov6o6OJ8Xb6k6KWw57D7
   XrcPq6DKHtGM2zUBAC08zqFov31LSgefVWSnwTEW7h4F5IhO/aSWTjHYk
   vHgG0rwiTp1xgEoGDpIRfFP+dv8fPS9b/dko+O7JohG7Kro/T7YQnKtUM
   X6SUiyMJv7mCXKI5thCRePDW0Unz+KZH+RpzHkRsCxPhNFXEOo4lig4gP
   DGhIvnCu3b9dzbp+dmCvKHk+FW6sTBwNpnD66Wng58YSRuCpvAjkYvQaj
   g==;
X-CSE-ConnectionGUID: 8u4A7gMTQ7KfI2G3n3t1Dw==
X-CSE-MsgGUID: LcRlwk0yTNGPlr0XZPoUNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="71701107"
X-IronPort-AV: E=Sophos;i="6.21,278,1763452800"; 
   d="scan'208";a="71701107"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 09:28:37 -0800
X-CSE-ConnectionGUID: 1KSBjfksTDKOXyEKrDaHSg==
X-CSE-MsgGUID: JqACOYCCQFSiMrROJ8MQJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,278,1763452800"; 
   d="scan'208";a="215343667"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 09:28:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 7 Feb 2026 09:28:36 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sat, 7 Feb 2026 09:28:36 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sat, 7 Feb 2026 09:28:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwyZQmreeRQJz8D0cnJieaAa1l9FHJzDcJp/NAdu+KnS9cYAApW/oChHkeTUHUZMty1xmwYypIJeIn7yVvnJCyv9S05ofHfJ7ws0JTWGG1YXfVltRrSKFKd4X0RLem1gJHkOOnHH8vIIG18K9IIQSUbkrufRMuCWF8Bz7vC42xFBKE7lJTugtDgcp6AlRmSP4jztwBooNfmdC+kOPjKAxX+W3MH992kt2Hq2EDtzSjskLPPEEzUrwna1CiQpxIWW8oUQNui3s3bTwXW/AAza0I+yPQU4Y5Kb0Hr9tN/SW0ZFi0p9LSX6bhKVUOeXBwnpKpnUEgJiWNBkU7msTPgryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jtgyR7gpnbxe5BKKbZfwc5Pt6e8RWcOyJij561zqJ0=;
 b=kqEt2pDxrZnmcPOZR7/ffYt0OCCQfInERTAiTd2edRPZw25dNnikVTyp3dsYuLfDH7BsLtJ+zVKdyCE7ANcNzQFy/pa//loNRlzndrAPcVyEHUx6yfTBJ5CcbEdtxxxWvmFZ1wXlmiT+SXTWvdEZU//4CgIKMKINwd9yXu8WBK0hIjnjx2vWxfdbjb7w4HAvQrB3YVMU/8W8B/O4NTbrvqIOmMIc8L9/VAXCATbolqVwlNduJANQdaCtuVRb19F0Kpag4CV+724cqodN+jmduIRraCQNZy0ML9tW0Yqf3QA6erhoBo8+cob/L1wzKb8ZzWsYalBFyWASEx2iwsidCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA7PR11MB9544.namprd11.prod.outlook.com (2603:10b6:806:4cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sat, 7 Feb
 2026 17:28:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 17:28:33 +0000
From: <dan.j.williams@intel.com>
Date: Sat, 7 Feb 2026 09:28:31 -0800
To: Li Ming <ming.li@zohomail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Message-ID: <6987763fea2ab_125f100f5@dwillia2-mobl4.notmuch>
In-Reply-To: <20260207133512.306128-2-ming.li@zohomail.com>
References: <20260207133512.306128-1-ming.li@zohomail.com>
 <20260207133512.306128-2-ming.li@zohomail.com>
Subject: Re: [PATCH v2 1/2] cxl/port: Hold port host lock while dport adding.
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA7PR11MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: b25f4eb7-65ba-494c-1348-08de666e5175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2pvRllXeGRKTjRNS2k5aThiSmVCZXdIVVI4UDF0UVNXRTJaRkdFSWErTGJ2?=
 =?utf-8?B?eEJpVUhMLzVvcmlzbytSQnJHZDEwWEloOU8wSHdpSVlabUN3c3NrR21zTmh6?=
 =?utf-8?B?aUw0SFF0c0lDMkNuVkRObVphZ3czU3F0SnBQSlBCS3h5dXZ4dld6ZVJUZXBR?=
 =?utf-8?B?cVAxOVJKVmQ2TGFRRVNPYWlrbTVETWJCYVRsQ3ZBS3o1SGZHQkxCclBXM2Ix?=
 =?utf-8?B?djRoRDFpL2lMVjZEUDJNT3FlK1FuUk5sYjN1eDc0ZlVRMzhDaHlRVjh4V0Rm?=
 =?utf-8?B?ajd2OTdLTFJlNFJkR1Z3R0tCOU5UUC83d3lYUXFwWDYrZEx2MEF2eG4rMVhm?=
 =?utf-8?B?QnhrbUNHV0FZalp0REJIWHVxRjVFQWlSWmdBWHVoRlVuajJNczJ5L1ZDMC9D?=
 =?utf-8?B?bUNYYmJxclVKT0FNYjZPWm9zNlpRdDdINlhhZHgzTWo2dFh2eGg3Nm12LzJ5?=
 =?utf-8?B?VnkwckRLa2N1S1hKK0E0eldPbDJ6QTRiTWZ5WlNMendpdkZBV0pQTDQ5UnBp?=
 =?utf-8?B?ejdKZEY3Qy9RWFVyaWd0YjBwVUVGeVNueVl5TStwY1l4VjNOOTdQNldCSUd4?=
 =?utf-8?B?TU05RjlvUS9YdUU3ci9yY0JuVUJmVXdkT28zc05EcDNVSVg1Q254NnlvWEcv?=
 =?utf-8?B?WlQvbEZJaVZDVXY5aTA5eFVHUFdkdEc5dFBIOXI1dVZpRDJiVi93Q1ZPVWhu?=
 =?utf-8?B?Slh4MnZ0QThNVnAzaHpMdDNQSlVrUmZmMjBQcjk5OTZjcnlVclFCcFQ2K25L?=
 =?utf-8?B?dklLdm00RVhOY0JjaHVkUGRISzVaS3gwMFl3MEloRnZaeEFOMXV6eGhua0dy?=
 =?utf-8?B?dDFEc2N3VW5FR2dSZGxhMS9ibjd5emJ5d28rQ3V1Y09vbWsveHg5WmptMkFa?=
 =?utf-8?B?MVF1T3I1c1duNmxHb0NZVFpJS1p2UmZYbzZDWW5aMnhiWEl6VEJ1Sk1mZmR1?=
 =?utf-8?B?RlZrRWdpNGp4dUwvcGhWcTZnc0twWThhOFg0dWJCZEpEYmM0ZU92UWUzdTkx?=
 =?utf-8?B?a1BFRGFVSUpGenRrc2JWVzBsejZwZ3Zka3BjNWpYVlVpUkl0R3RIRlllMG16?=
 =?utf-8?B?TWQza09Pc3RzNG15Y3NhRzVVeVZ2VHE2NHhQK1dVWTF2M1dKa0pHRTlFY1k4?=
 =?utf-8?B?MzVnLzQ5MzkrSXBIcENMNkwvR2ZKazJaZ3pubWg1ZUFiVWhaZFJlcU9jVncx?=
 =?utf-8?B?amp5VnRrUDRta3JOS2FQemRSYWZRNFlLTnRkZU5Vdm9odkdtdU9XcTFpZ0NI?=
 =?utf-8?B?cW5ubkhoTlc4Rk55ZHduajBOcXF1T3BVeUl6RGJVcEQ2a3NXbU1XKzhWRmox?=
 =?utf-8?B?aFRhUGFSTXNGRUVHeVF0ZkpDSWh0aVRVME5sYVVPa0duRVF5c1NwZkNzMlJ2?=
 =?utf-8?B?ZlZLZFRnSFY4cG5UVkoyOVR6a3hLVkMzd3lWYW5tbU9ORVhYRFJEZWFkby8y?=
 =?utf-8?B?VW9EMFFpVVpUTTBQOUZGblljVDFiZkk2TS9lbEJuaXY2QUhhbHU3UWxvckR1?=
 =?utf-8?B?SEltMDE0Y053U2JtRElMNzBJdFhDOXFDcURQV3RrVFdIUjVUU1pOMjNLT1h5?=
 =?utf-8?B?MnROWDRrYm9uTUtpVjRYelhDRjB4U3U1am9KTWdJaGs3K1ZiT3QrcG9EOGpx?=
 =?utf-8?B?dXZra3hKQXVhVm4zRkp1Zmdvd3ltcEdpQnVDbTUyVlI2N2s0aUZzR3hWY0c4?=
 =?utf-8?B?dkhiL2RBSHhPTCtZTys0eGJSZzhpU1BaVTFPVHQyYTdrY0hqUmowZ0dQQlJ5?=
 =?utf-8?B?Rnc1aC94eHFXV05OL1doQURoeUh6TVRGZkk3TVFXK2tjd0tNUE9IeVQwU3RT?=
 =?utf-8?B?dHV5eWQxSGdXY1NpeEFFOXFzeTlPU0ROa2luQVNLMlpCZ0NzQm5VT2pUL2Vq?=
 =?utf-8?B?anZhVkxxOE5uTGdTdzBldWZPMmtTelc2ZmhBNm5SOURYb0FzZDVNWVB0YlNB?=
 =?utf-8?B?SVRENi9yeGdSNU9Ya05RZGQ3ck51ZzV3b3FGZ2lSUlVZK3d1dGl4MlJwS3A0?=
 =?utf-8?B?TFZ3WTNTdnlabE1EVEREa3pWMHYvODJsd3ZhYkZ1N2RZaXhrVlp5K0NnQ1pY?=
 =?utf-8?B?NzE5S3JlaW9XSkRkSnNrZjhqN08xVGgrRGpiSk8wdDRHMzN3dlkrOUZYWkhm?=
 =?utf-8?Q?wfpQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE4yRTRQUmZZSXpFdUxGc0ttNy81NURETXpwelhhRmFFcjlpL3Zuc3hKQm9L?=
 =?utf-8?B?Vk5nM2ZsNnpjQnF2TXk4WTUwc1FQUlFCVlFvcXlQNFBTQTdKblRCb0d4OXY5?=
 =?utf-8?B?UGNEcVVIYjM2cHF4elNrNTFRUzhVRm5DZUo5MzdmSVpsWFZVdVpyU0doVUkr?=
 =?utf-8?B?QWRMTW44aGNFdFNGcHY0MU9iOW9EUEkyRncwempabTFURHo4N0Rsd0ExcWk3?=
 =?utf-8?B?RVRUWmdSMld4YTFJd09DVjlwdmZhNGdEbW9zQnFOUjQyeHEzWmZ6Q1VJNHFs?=
 =?utf-8?B?UjRkZ0JEdVZFY2JQZUl2SkxOYWxaK1MveGRaWUk0SVZyc1FlRnBvZndXSXdM?=
 =?utf-8?B?UElmRE5EdkUxRnVSTXR2K2RqSXJneGo1YnhyTjBBTml5KytSSmRHUFBMc214?=
 =?utf-8?B?WTI5alhBc3hTcE1GY0YwMnpqRjRzSm14VjVSOFRZSGpaK1JpQVk1OGIxOVhk?=
 =?utf-8?B?anM5SDBSd3NrRTB3VFRmQXYzTmd5VGpUY1Z4MjRGMlJheWZCM01pRkFyb1F0?=
 =?utf-8?B?KzcrYnlvZ3ZTMTVYOGtmcEZ6L085bll3WTlhci9iQ0FlTVFuWW1ZSjdJQTIz?=
 =?utf-8?B?eDRYWWFrd200MWtyZVo0RlAxTmcwamFCM0NyKytpTEtDV3pLUnVoQWZSbEVu?=
 =?utf-8?B?d2prZWFnRzdBdVBCc21TOTVreEZHc2ZGSjdUdzJUUUpqeUljOVBYKzUxbElk?=
 =?utf-8?B?N2p0UnRpN05Lek15ZzlyeElWbjRsMjBJUTRQb2dwQUgwRUtEZHpoRUI3TENN?=
 =?utf-8?B?UmdMelo3STJJbHFsb2tiOEk1bDIwS2xma1dSOEhwZ2lnTDRHSlZycHFqWFo4?=
 =?utf-8?B?Sll2RVVQMm9jZkt2dVV1ZkU5a0ZUSXRNRXBBK2w4SklLVVJBRFBRTy9sVkF6?=
 =?utf-8?B?MWZESmxFdE9iaWRLd0RIK1ZvZjlqZU1wTjFsNXp6MVMxZjc2WThIZG1zMUZD?=
 =?utf-8?B?emdBT0RLR0hZcHlXQ0t0eGtrZFVWdytuWWN1bWZsUTJSQ1NEcm1jdEVPNnQ3?=
 =?utf-8?B?YUVPVzgvdjZFc1drNVhqTU1GRGl4ZHZSTDdDMXhobU94TmQ5VExXWm1xZjVB?=
 =?utf-8?B?eTlnMjM1VHBRTmtTWHBndnh2MUQvTlAyeTF5VFdndC9MdGwvM0tXWDgxbU1i?=
 =?utf-8?B?WFcra0NhQjlobkw1TG1ucWxLSVhMODZBdU5qUGZjK0llTXNLbmpqSE1iNWJv?=
 =?utf-8?B?L3ZUb1ZQeldGaldFcjM5V2ZtbkFnalEwblkxTmNSYzR6eUc0U3FXR056bGd1?=
 =?utf-8?B?OUZpbVUxcXY4Ti9lMllGRm9pN2dWQnBnMFVTbmVoSDMwNWxJaGpnVlY5WEFx?=
 =?utf-8?B?cjQ0VjFmUk9Ed3duemRpYXVVNEdoQVFoUyt3VFM4MVFWQ0R3dDBoOC9lMGw2?=
 =?utf-8?B?MEZCZk4xWEk1M1lOa2xHenQvajBuZldDSk1iZWwyM0JuSFd2WHpzbXMydHFP?=
 =?utf-8?B?YUY4MVgxeXgyZ2YycDlnejhGaDUzNC9OQWhFbWFuaFlLOUdrdytiTUVBemF0?=
 =?utf-8?B?UCtaRnNFV1BFN3kzakhuUmpsbkhBYnZkcG1RSG9wZ1lzclEydTF2SGNhSCtu?=
 =?utf-8?B?YnhIVUZQMDZaVkVCalFGWDFnY0dDWUFJNXc2dmlGQUlkc3NnbTZKNEVTcUlH?=
 =?utf-8?B?Rm5nVjZtUVh6MGQvVU40bXVhdEc4Sm5OOC9vYTdYODlWUk5PeGNTNDBQODVl?=
 =?utf-8?B?cnRaZUJVdGYxVXYraXJBLzBHc1RHdmxaTlpVZmszL2d5KzBDdFBnUlltVzVE?=
 =?utf-8?B?RXRvUHZSZXdiMCtsNTZXVlp0Y3VMSzNXVHhodTFGMzAvbjJObDZEdTdkN2ZQ?=
 =?utf-8?B?VEJraFJ3T0d5eE9uU2ZHS242TVU2NGxMWWNOandscGlEL2h5U3M4N0pIVnFB?=
 =?utf-8?B?SzBodXFUM1dMVC9zUnFaRkJwdkgyeG5aSVhQL3NwcFBKYUxwVjFHMzRCY2Vv?=
 =?utf-8?B?RGpraHlLTWk3aVVaTVlPZ2svcmtRSGFmUVY1b3JPQlJ4cFpuSzd3bld5SWN6?=
 =?utf-8?B?TTA1dVBPN0dQbU1iUXVYTUZqVWo0TjVIZ2g0NkczN05UTUF4dU1tUWJqSzVY?=
 =?utf-8?B?YVF0enBTOUYza20yRXdOT29maEM0MnJ3YTVhUEZIVkRIMzZaY2tCb3N5ZGxL?=
 =?utf-8?B?ZGtFSk5YK3NPK3E0WU9TMk5RVFAzQVBNWDUyUmlNZXMvNHNRMTdUVlhWU0gv?=
 =?utf-8?B?QmNZbHhtdGx1SW9vWGZ5MmF3Rng5T0psUVBLYWgwM29aSVZobE5aNDB0djIw?=
 =?utf-8?B?WHAyU05TL2pSZFowdkRlUlpwNnJ2eGZhL0dWUnNsVWx0VWVncVl4UklXNFRO?=
 =?utf-8?B?UHBnaS9tQzJ1UGdOZTRhODNuV1I4Q3ozNm9CRmJoRGpYMkpoVGo5YkNIN0tp?=
 =?utf-8?Q?etuaB+JC2VwrRZpI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b25f4eb7-65ba-494c-1348-08de666e5175
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 17:28:33.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bc4sZ7L+ZlUFAKB3Fia+oXadOQHwyfqtlNte+83N43MSJ73aEZCvMX9NLLGFxZyQo4Tedzx5iLfj1HQS5A99oVAbQv6ZTHkOWCYQ2vgEvAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9544
X-OriginatorOrg: intel.com

Li Ming wrote:
> CXL testing environment can trigger following trace
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
>  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
>  Call Trace:
>   <TASK>
>   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
>   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
>   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
>   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
>   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
>   platform_probe+0x9d/0x130
>   really_probe+0x1c8/0x960
>   __driver_probe_device+0x187/0x3e0
>   driver_probe_device+0x45/0x120
>   __device_attach_driver+0x15d/0x280
> 
> When CXL subsystem adds a cxl port to a hierarchy, there is a small
> window where the new port becomes visible before it is bound to a
> driver. This happens because device_add() adds a device to bus device
> list before bus_probe_device() binds it to a driver.
> So if two cxl memdevs are trying to add a dport to a same port via
> devm_cxl_enumerate_ports(), the second cxl memdev may observe the port
> and attempt to add a dport, but fails because the port has not yet been
> attached to cxl port driver. That causes the memdev->endpoint can not be
> updated.
> 
> The sequence is like:
> 
> CPU 0					CPU 1
> devm_cxl_enumerate_ports()
>   # port not found, add it
>   add_port_attach_ep()
>     # hold the parent port lock
>     # to add the new port
>     devm_cxl_create_port()
>       device_add()
> 	# Add dev to bus devs list
> 	bus_add_device()
> 					devm_cxl_enumerate_ports()
> 					  # found the port
> 					  find_cxl_port_by_uport()
> 					  # hold port lock to add a dport
> 					  device_lock(the port)
> 					  find_or_add_dport()
> 					    cxl_port_add_dport()
> 					      return -ENXIO because port->dev.driver is NULL
> 					  device_unlock(the port)
> 	bus_probe_device()
> 	  # hold the port lock
> 	  # for attaching
> 	  device_lock(the port)
> 	    attaching the new port
> 	  device_unlock(the port)
> 
> To fix this race, require that dport addition holds the host lock
> of the target port(the host of CXL root and all cxl host bridge ports is
> the platform firmware device, the host of all other ports is their
> parent port). The CXL subsystem already requires holding the host lock
> while attaching a new port. Therefore, successfully acquiring the host
> lock guarantees that port attaching has completed.
> 
> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/port.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 5c82e6f32572..6f0d9fe439db 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -612,6 +612,23 @@ struct cxl_port *parent_port_of(struct cxl_port *port)
>  	return port->parent_dport->port;
>  }
>  
> +static struct device *to_port_host(struct cxl_port *port)
> +{
> +	struct cxl_port *parent = parent_port_of(port);
> +
> +	/*
> +	 * The host of CXL root port and the first level of ports is
> +	 * the platform firmware device, the host of all other ports
> +	 * is their parent port.
> +	 */
> +	if (!parent)
> +		return port->uport_dev;

This helper looks good and this case is theoretically correct, but I
assume that find_or_add_dport() never hits this case, right?

How about move the introduction of this helper to its own lead-in patch
and use it to replace the open coded version of this pattern in
unregister_port(), __devm_cxl_add_dport(), and endpoint_host().

I do notice you caught the one in unregister_port(), but there are more.

With that change you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
