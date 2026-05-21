Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB4349CD7;
	Thu, 21 May 2026 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346384; cv=fail; b=CjqnqCWLM0/Dn3HQ5Q2vXqPJdcKmgYPBbBrTdkzvsZLNSWf5nIWmpBTJdGgawSzKKKI5mVId+RgDXZduwUwpOdHGvkXR9s9jILwclkD22D3/abhCBBpNh07k0DkZqXP4edbZCEx0RJYrRV/gShcBRTJVUmnnHq4WBUxrRPchuLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346384; c=relaxed/simple;
	bh=GCfddeldcMu74Brcs2TfLfPaGBP7hGjVE16IuuLz9KQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c0kUVB3koHtjtsjSOuy+x1lHqnwQAM/Bo20a552vr7HPWCJ6vXcPKBPG105fA31ustegJKwmdN71PcWA/uzM4p3wh6uLk9ZRIUNp9bG5yjZcEHr0sTvDJaVbGaANPHidJRRXzQPO5QikZXZICDDrl2/3iFfN2HFFhPMOoIHcF58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIOUytk2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIOUytk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779346383; x=1810882383;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=GCfddeldcMu74Brcs2TfLfPaGBP7hGjVE16IuuLz9KQ=;
  b=SIOUytk255Uv2AG2TSu8AcF3W6aGvNYH9xUaom0rS3xELWDgVNKMTnVG
   aDHWfKX9Yi+izUQOT75PCa0eUo7pJqOGyXPwLTdLbfA7/KRIu9kyznJml
   zTe/URMYMhyXc8WFVXwo2ViYEgWnixLf9ttRCd/rMD0swGS/hCFHQCjQM
   QujaInJOnvn4XRwI1vQBHe+HtHuD0b8T3bJw48qRDMUMXUuGCJ+Ixm99k
   R4nHIar59b2SKDlFZd226HMJD/ZEd4K4pyNuoP4sXp2RV/NGZ9fnH2A8j
   DnKTw1Z8xPwyp/3TiJlhiurXrKr2vg/gw6nxE64zvuSNjqiCT+a1vz0C5
   w==;
X-CSE-ConnectionGUID: G/CVnD3HQEi/x0SRoQYERw==
X-CSE-MsgGUID: m4aSxf5XQTCfnffbdjjQgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="84144966"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="84144966"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 23:53:02 -0700
X-CSE-ConnectionGUID: i/EhZRgESe2w3NzuD3hvGQ==
X-CSE-MsgGUID: OccI1B/WQpmwR2Pw58LO9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="240682616"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 23:53:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 23:53:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 23:53:01 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 23:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAPsR14MxnSpKcVZyHTbGerEsEjK6fBpBmbg5auzI1PbrS4Rvz16q2OFTp1O5k8vY18Hj3uLY/J9mY2WzJYiUd3MQDYCgH8iiiz1uKFzRDrxkiFGYpJJ+cZsEhmaVDyith/J+k0CoaHMIZMl4PDLrG3K6zTv1Fp/zGUcQ5flVPCWIUxaB/aBLu/DGxP2ghQrp/ko8eTSFl7vp0ORE88EmV/O0OdLdDIq66XIZ24b9DA3/z/8IDCMLUXi0/58YekaM/v7pe9JrB2F2/+yAZr1pOe6qkkoG1e58uKpeUtq+5bVVR3atjV3FqRRUaZbflMyXrnpJXn8/M//8NfAlxXMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itaqYAqJPJvQqxHX6ZLy9tPxWYD8Ywk1kodZt2Ncunc=;
 b=YoFA2/3B8gLd9rLlEHmmU0xuCIr4sd7ZChvqBOQjpf4snulswgeK84wNcrNlz9kfov4LBsxmi5ng9eaYLo9A4cHAXJEtMMssHKmvZew9QlB3/Fj/0J03K+fINkoCZe2Io2I0Qb62UPooGYjb2wv5My3Sl25Q6CwpnbU0v5juACvpl1bCjpV6/Yok11g32LUjCMDRrdb9QU3ndnCFo2xz8orUV40UeY84vMK1WGSOBjdaCMjS/K19xXz/x6K00CP7PBKAmbDo/c/FYAyh+ryEFnQBY7PBSmDHQ+PHNNZxBzwyGJJ85j68YLeESoKUbXkCr933Mh7F/S2bHvdJv+Qqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Thu, 21 May
 2026 06:52:52 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:52:51 +0000
Date: Wed, 20 May 2026 23:52:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Jonathan Cameron" <jic23@kernel.org>, Vishal Verma
	<vishal.l.verma@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, Dan Williams
	<djbw@kernel.org>
Subject: Re: [PATCH] cxl/region: Fix out of bounds access in
 cxl_cancel_auto_attach()
Message-ID: <ag6rFgctpwSNPWgt@aschofie-mobl2.lan>
References: <20260519-fix_out_of_bounds_access-v1-1-55fc60d83388@zohomail.com>
 <25b0125a-b0fb-4401-8596-3252d2f8cbd6@intel.com>
 <cedaee55-ff31-4aa0-981e-938db56b2b45@zohomail.com>
 <8a835dea-956f-4eab-931c-e1a54e14331d@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a835dea-956f-4eab-931c-e1a54e14331d@intel.com>
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de54725-9217-44f2-5dd9-08deb70593cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|18002099003|56012099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: nobbiFoHi0pNLB/Yg3nOijKvXqh8aAkDdVQCzSaIR4shciiKZ8FqR2pZWeJ8vZjm9taWY6XY20mSDJbKNW6etKy6uE/OBNZe8dqTHXz48nD7nR1amJKK0VUEaO/F0gvs0Vt5SPNBgubq6E6XPibUve+a1OwAfVyFhA8BNATCmxdBFW1Tp6R0lpvgYsi0K1cTj1dl0verzaCMgfEeIIlvmnwHcdDc3CVCv9j9Df1S+peW49KsnwOKiVI6EeUePYkoYfEntD/gkZ82MS8k180BI5uR3Y790YK8Z3hnV2VNhzeBds8LneesNGGXLl8cSjw/GwrjT4vRe8GO13a+Kx2w8x8BST41g8HXoC6XmQ3vjTf9UV1+HU4qkl75k7dytmPES0qR4K92lahdQjkNegO3QNmSXg5tMX9U9njU7KZCEjkujIr08iLG18IymEMcn3RoRYALexpRlGUjrPn27XGQaeHNXLKP5MGrM+hFLhBXkDO38oszdrC3yJm9og8mrEaJmVEvv4OcL5IQDPHTUs4X6c1bccaGMzVRAULivyDIEFcUXZI3HatPrMQNK454ROIHdawln2famQ8PG80z+/1n7gniambhmFiwbMRucWHgKVlkTnHAewiovF31A1kInHLjotmObT2VIu4zBQUO31vG8VHpiN0x+AA75bYu0wruiEXxVTb+WjNpukRirh9XASWL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(18002099003)(56012099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHNwdUdqZWx6cC9iUExWSWUxL0dNWCtpUU1xdlVtb1lpZnovQzRoR2NwMTFm?=
 =?utf-8?B?dkduUWRhMWhqREhsWHlUQUEzd0JnWmt5QStpRUw0UklabGVLYjFFVGl2eU5E?=
 =?utf-8?B?ZzBzbnIzOWIvQUhSaXIvNTZYK1dTSDRnM0Y2WG8zUDJrS0wxQXBCQVBTeXZ5?=
 =?utf-8?B?KzdMSkNhcVVlVi9IdGZwcEVnaUk2bzRKaCt2K2Ezc2ZoZ2t2UHVhUElFbFlP?=
 =?utf-8?B?NlQxL0hoZVBFY21taEdWRzRCRGhXRVRnNmdaR2ljUGwxc1d6bHJhcVB4K1Mr?=
 =?utf-8?B?cU9sVnBkMHZ4ZjlHVjd5UHo5ZDNyNHQxd1k2WGpJTEljWlJlTk1IWTdlQW96?=
 =?utf-8?B?ZFh5SzU0Nk1UWUdhZklLdjRCdW9heVFRTTFWMm1TVFpoS1B1aHNVR2Zrdm10?=
 =?utf-8?B?SDFxVVdjZE1kdnVFenpSdnVkeXB4SzFSbWlVZ1F4SGlyUWN2ZUQrdmZQL1dn?=
 =?utf-8?B?ZFlJWTZFYWxIZTdHVHY2R3gzZ3lLZ21FMVdMeDJwOTJnalJ2SG1wUGJmV3Y5?=
 =?utf-8?B?ZlQ3dVJBSGpBTldWUXJPZkNFV0JjMDFncnZUbG5WbUhqYUtDUUNoN2xQbElQ?=
 =?utf-8?B?ZWRyS3hNRXlyN2ZpV2U2ZHIwN3oyOWlYYkpyUFNkeTRBa09jeGVNSDdQMXd6?=
 =?utf-8?B?ci9SNkVyTjBVQTVkcUpxSmFmWGo5ZzBPWDZFUTQzczhXc2FsczhMNTZCUCty?=
 =?utf-8?B?WnY5dEJYOXlHa1pMcjVaYW0xT3pZanBjeFZpZU5INTVvWloyZlluZ0w2V1dK?=
 =?utf-8?B?eG8xRmFrQVhrZHF3RksvWjNLQWJTNys4YjNFYVhYZDJPWWdDYkQ4aldSQVgx?=
 =?utf-8?B?VjhGQTIwQ0VuSFl5enlxNWJldHFKQnhHL3B1Y1BCMDNNUW1vVUtpWTl6dHkw?=
 =?utf-8?B?TmdZUDdES1liOGhoa1I1cnEzZW53dWVVd3V5aE5icHkxdUxmT1BQbU5xOU9i?=
 =?utf-8?B?RU90WWFoeXl3ei91WEYybEZzS0JDU0FyWnFxcUIvS1p1SGp0ZGRUa2dhMi9Q?=
 =?utf-8?B?dUVBdGJMOFg2OG03K3g4WlU0QlhwOHBxQ09ybGNLN0VIUUJEMEVDUDk0S0Zz?=
 =?utf-8?B?SmtIQytVcEtMMnp6ZW1CQVJQWndweENqQ3VLeE1TUDB5NXgrZGV6M28wYTFz?=
 =?utf-8?B?YnBmQVE5ZWVrTmlkYnRiS1Jpa2Z5cnNIVzd3RG5wWVAxUGlrOVY4RDMyU1ZQ?=
 =?utf-8?B?ZlVuSzl5OU1OK2FWekxEMnVVRUh1WkQ4WFdCK25aVmhTQlJvR09wTGFLdlNj?=
 =?utf-8?B?ak9RbWI4bG9XMkZYOVh4TWxUUzZCNUE2cmNIamNvcnBFS0s4TDlhamxFejRY?=
 =?utf-8?B?MkJpWGdwNUd1dDQrMmJVZUhaOUFuY3pxejhLVlgyaWhVUzAzem9tNWhSUnRj?=
 =?utf-8?B?dHdBc1pZU2JlYzU2S1hEWmRQKytTMGNMM2F6b1VVK21aazYyaWcwT3ltQTdj?=
 =?utf-8?B?bWpHNHNxRFcweGVMcmZSS1pOUmtnTGhVUDJsak1NdzNrRlVoNW82TEZDNTgv?=
 =?utf-8?B?ZzAxM3NjNGtaeEpOT2Vma2NWY3RVV3VKYTRkNnZQV3F2Q2dkQTFXTkxuNjJr?=
 =?utf-8?B?MWMwaXZWc3pjMU96VUtneGs3S25zVTVUeWNtMXp4RGpORUJHK2NsZFVFSjJk?=
 =?utf-8?B?UmlVc003WU1SSkNsTHNwSFFURFd5dnpLSW54bjhBNnBmdllVdkQ2U2ZMQ0lO?=
 =?utf-8?B?alpWYWFjU3V1OUlOaTVYRXpBcXNiQTIwNTlnd3V5VVRmMlFBSmRYNmlUa2Rq?=
 =?utf-8?B?ZlNxdlFCclYyOGNFdDduTjFKWHlNSldrMVZJcTd3TjFWY3ZXSkk4WjdYT1JX?=
 =?utf-8?B?aEM5YUkwVmJ2RG1hYVdqaVpVSUFPcUlTYXZLTHRvTUxQZUlQSHBLWHowdFVE?=
 =?utf-8?B?UnZwVG1ZMmwrdmw2QUVSeVYySkkxdmtNckF5WWk2KzlkZjc2ODRuQ3BoaUdn?=
 =?utf-8?B?bmN0VGZMWmxXRi9MWmV2dU5kSm0vdkJzL0dtQmEzK0ZxYWJ1ejhJdEF0czds?=
 =?utf-8?B?bE02dEUxdUtWak1MUmFHYUlFM3V0TlVWcGFFSTlUU0NmRmtublFHTk55Tmc0?=
 =?utf-8?B?ekt0NTM0Vk5SMi9JUmJ0alhJekNKVjVUektkWnZOWG11aXJNVWRKWUZlelEz?=
 =?utf-8?B?SFJ2Z2JiL3dCMGFqYnZSQmk0RmM0bFIvTTJZbWxCZDR6bjIzQzV1WVFqSlZl?=
 =?utf-8?B?M0lEMldjN1JURktXVGVFSnJ3VnVuSVVkbTlKVUlpVGNTRmRzSEpBZDdPOXF0?=
 =?utf-8?B?YUR1NHUzdkJNaXlSSzZBODRLL3RzdjRiRFA5L2JnMFJlcU5vZnZLbzFadVdo?=
 =?utf-8?B?NVJkcGxRU2NHUDBOaS9kT1ZTVjdpaVlmbmdPT3lnV0pPVStsb3p3Zz09?=
X-Exchange-RoutingPolicyChecked: gePzE+9lTrEMUkzfyzznsmHAwzbFRxAI3KVmOTKXFzSnO71Ov/KnsvKGbWfSLnmJB1jMeLwoWWXr/tT/T67lzwgRSIIePTt7ugR3M43E9xlVN+WdBB1IMLHzbqTs4CXQwxyRIBDHuCYSCz4KZalv4yXdqXAxbznDbWSZeX9SIggkvBlb10Ox6cDq6ZbA7e67IsV9ipeAMEFMor8fywm9+7aE/wHE0jP/YtacRNtb+ik7GikcFhn7nSBKCoUc3ON5cQAK/2AEcmqNAi7vWAuuT/8041LczZ2HQhsSkgg/owHUMwYRYKk6kOvmkUX4hjKRobYy8ZiQ0Bx5VxKBZVA9vA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de54725-9217-44f2-5dd9-08deb70593cf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:52:51.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGT+i4kTbh+OYSoks9rwn2T4whfI/Gs/FVTiM/CcidvOdfmf5Q1jJvo2xxnBzE2rVSRubk/w9bSliEyjNHnc4YrhRiXP+2PcWUfm5x1rpW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com

On Wed, May 20, 2026 at 07:59:21AM -0700, Dave Jiang wrote:
> 
> 
> On 5/20/26 5:30 AM, Li Ming wrote:
> > 
> > 在 2026/5/20 01:18, Dave Jiang 写道:
> >>
> >> On 5/19/26 6:23 AM, Li Ming wrote:
> >>> In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
> >>> accessing p->targets[]. However, cxled->pos can be set to -ENXIO in
> >> It can be set to other error codes I think? I would just s/-ENXIO/negative errno/
> > Sure, Will do that.
> >>
> >>> cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
> >>> causes the driver to use a negative index to access p->targets[],
> >>> resulting in out-of-bounds access.
> >>>
> >>> Fix it by walking p->targets[] instead of using cxled->pos directly.
> >> Does the comment in cxl_region_sort_targets() need to be updated with the new changes?
> > 
> > I'm not sure how to update the comment in cxl_region_sort_targets(). Any suggestion?
> 
> idk if we should just drop it entirely since the comment is no longer true. At least that second part. Alison?

I'd like to see it replaced w this so we continue to have the
debug info, but stop the lie that led to this issue.

/*
 * Record that sorting failed, but still continue to calc
 * cxled->pos so that cxl_calc_interleave_pos() emits its
 * dev_dbg() for every member, which is useful for auto
 * discovery debug.
 */

snip

> >>> +static int cxl_region_remove_target(struct device *dev, void *data)
> >>>   {
> >>> -    const struct cxl_endpoint_decoder *cxled = data;
> >>> +    struct cxl_endpoint_decoder *cxled = data;
> >>>       struct cxl_region_params *p;
> >>>       struct cxl_region *cxlr;
> >>> +    int i;
> >>>         if (!is_cxl_region(dev))
> >>>           return 0;
> >>>         cxlr = to_cxl_region(dev);
> >>>       p = &cxlr->params;
> >>> -    return p->targets[cxled->pos] == cxled;
> >>> +    for (i = 0; i < p->nr_targets; i++) {
> >>> +        if (p->targets[i] == cxled) {
> >>> +            p->nr_targets--;
> >>> +            cxled->state = CXL_DECODER_STATE_AUTO;
> >>> +            cxled->pos = -1;
> >>> +            p->targets[i] = NULL;
> >>> +
> >>> +            return 1;
> >>> +        }
> >>> +    }

Sashiko review looks like it is calling out a valid 'hole' issue above.
Does the array need to be compacted when we remove an entry that is not
the last. That would keep nr_targets same as 'first free slot', so 
there are no NULL holes. I think that fix goes in a separate patch.
