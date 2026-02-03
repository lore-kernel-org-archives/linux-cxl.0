Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E870374720;
	Tue,  3 Feb 2026 22:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157509; cv=fail; b=YB6RR82dZu3oVqvc7y36Z/A2HXKmoRe/o6X0+KCLSu/UzhmsnY5OXK8NYb60w/oZ1NMlnNu1vWW4LDhfU5qDCeIRA6/3CPy9pasfRlni+2lyMR84lCyUElgxVLQrc4+pCfw9U0NIyILSAJmdysPt0Qia9Y9xAY2XFj8egIJoKh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157509; c=relaxed/simple;
	bh=2OKpz3BKyGB+jBQmc7XwrTFiCzIb9J4UtZoV4OxPF8Y=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=t/1kv4cotO+7M4jTd8TgDj+fLXZ7NMu8WBz4qBmisLMfTq1f8/omTDFbBKEFDS79cHHt8z4VpvFZ4BU1jgFBs3ftsA2ZNSNBw3Da4v/fmttPyCQADpwgKyzDbwuOznws6GZNrHj2lM8mT1OmDXV6dNpV/7ASy/p9t2I9Kt4dU8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dm0JcVSu; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dm0JcVSu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770157507; x=1801693507;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=2OKpz3BKyGB+jBQmc7XwrTFiCzIb9J4UtZoV4OxPF8Y=;
  b=dm0JcVSu7yujIKxKCKpS1ajILy3P7nitDUfGA5B4zFc1HQ6lThqFjAbb
   glklm/jXJ/kbfnHpPAfQLS2y2lZTmKcsmWssNa+rKOSx+JPClPhdnqrp0
   rTFdRHlTLCPR0FqdT2YjQlPHvCGvcMjsR3GaDyXWeLCpeQOIcMG+6IEvM
   bE/zlh1rVFpeZmqcJjWTXidC8BwZ4Yvmxglf2zdDB3Toyx1ZMTuXKuzoo
   +zRi+SVst1dsw35Vq0V76gzzlvYOEekzQRpPD5OYQW5V0cjDZ89aUc6WZ
   GDJfC6sWCplN47qCGn4sE+IHegwqDjNzAYLFFu/Iw4NgLxDHUcdRxEkZp
   Q==;
X-CSE-ConnectionGUID: hWN5GBmdQZK4eurUlMC8ng==
X-CSE-MsgGUID: uW8LY7ZcTciK+DUiB8LIUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="73940685"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="73940685"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 14:25:06 -0800
X-CSE-ConnectionGUID: EiM1uIzzR0ytjk57wcm8pg==
X-CSE-MsgGUID: y+tb9kXvQyW5Ef2vX1kJNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="209263814"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 14:25:06 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 14:25:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 3 Feb 2026 14:25:05 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.36)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Feb 2026 14:25:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O40w+0q9Ug27T6j69CUr/ZtpuBwr5/tpiTU/Pv8/cHZpQRO7Ty29bdpR09CxgoiRTR0jp2n1Gyn//hZc7SPnXphrYh6KI1rSM3bgoL0TuaPXFaHYhJmZmcbMmB66trl0tLxe8K6S+LdkZNC/iB9fcU+Iy2LE54+OKObihUEWvdxQy9F1uxk2k8qgiuHQ6jE7T9tJezCdy7oXrt5wqeVR1GqwlumPb0LmNQuhKKdibdHKR6doTTl7eGmtjdi960cD9U6xG3S/ARptoOnlUdtx8hovkA3lZTyHphCXcN6xzC1eL3qgksTFbqYwzDAVHYkQ0TKSa4Q4mJjAoWuxBI5nVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+88Nvyezzd+gOkvDSSIRQ4SeGhzz8VMwh9BqvQRZMEM=;
 b=vQBpVXGixxtOIA3FMEX4m/JLswYb5wvmogKguXQp0Z8xgIyUTrjauGsEKrOwtzjevBg5dP6IDFBW9LU7OMipwGKTnIZxocMvGYnlNozfd1mUqJqG4pAp8t5rfxYnQLIV30QVnVvNyiOB8wvHUq11g2BYmrpYv0zuVIByhmXcRWrHoB3by2WS/LTeP2gu0ioVdY8P5bUheoeUbVf6ypKimW2NJxzs8/mVCoJEx0EVKNgro3UJlfu3Xc+OHskDv/ZkmLkGIhzTIXE9I8WBSfC7TwKZKo/2SybhyCaL+bqP+gBUyaV1pwaZKmrbR1GBPcJD4hVxwhj/3zeZCqpUghsygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7077.namprd11.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 22:25:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 22:25:02 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 3 Feb 2026 14:25:00 -0800
To: Li Ming <ming.li@zohomail.com>, danjwilliams <dan.j.williams@intel.com>
CC: dave <dave@stgolabs.net>, jonathan.cameron <jonathan.cameron@huawei.com>,
	dave.jiang <dave.jiang@intel.com>, alison.schofield
	<alison.schofield@intel.com>, vishal.l.verma <vishal.l.verma@intel.com>,
	ira.weiny <ira.weiny@intel.com>, linux-cxl <linux-cxl@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <698275bca732a_55fa10097@dwillia2-mobl4.notmuch>
In-Reply-To: <19c2417ddbc.de6bcafb8090.2871009931423392945@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-3-ming.li@zohomail.com>
 <69813c31200a6_55fa1005a@dwillia2-mobl4.notmuch>
 <19c2417ddbc.de6bcafb8090.2871009931423392945@zohomail.com>
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport
 adding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0198.namprd05.prod.outlook.com
 (2603:10b6:a03:330::23) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: bc796ca1-f29f-442e-1129-08de63731305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckluQmxlMU9Ha250b3BXa2pzdVo4N2pQUnN4c3lzV3VFckZWdVRHb1dUeFVK?=
 =?utf-8?B?OFBDMlovSXRUdzBwRGFkSWlnT290d0ZvL09LUE1wTGVYNHpkNElBTjhxZnJw?=
 =?utf-8?B?SnlxSzdqQWdrQU5CbGdTTXJ2bFRoSWlESEw5TUFkZGlzQmplOXRmZFNWTmxv?=
 =?utf-8?B?OFA0MDkxQ21uaVl5bzQ1TG9zOFVpNTJzUTJKMVJ0UlhkRDlkNy9xTHB3cnpt?=
 =?utf-8?B?cHhuQjdFRldxY0Q4MGJSaksrdk81RkZHOHU0Q0JKTGUrN1ZDRERQRnZCWnc5?=
 =?utf-8?B?WGRjcy9qeVV4VXlucVJEaGFiVFZxS1o1dGtJUFpaVlN3WmhiOEpodDQ3VUlz?=
 =?utf-8?B?UjIxYnlHSW1KdWhvbTdVc1R4by9NZG5HOFhsT0V5MWtXYkZTOWl4OS92Y1dF?=
 =?utf-8?B?akpGUHVLMHYraDlFSUtPK3BFL3lja2JaWXhac1FqS1Q0QWIxYVFwTXBMUHox?=
 =?utf-8?B?a2MrVEFCS1BiR1FiQUFnS01kNm0rVjIyQi91Y0M3aFI5a2lsZDNsSDVBd2JV?=
 =?utf-8?B?ZkZDZVFkZGpERlhaaE9sYlUrOG9nRWJyK1JTSjBVRXBNV3hhamMvRE8zbHFh?=
 =?utf-8?B?OHJkMGhTSXZtaHhGMWVzaWxETDdCajFyckJNcVJ5SWJxaVlSNnVKeTVXMHAz?=
 =?utf-8?B?VkRXVVZQNGh6TDFKdi9Nbm5MYk1sRjduR0JHN0J3NFJrVWZNSnZMdm5yczZW?=
 =?utf-8?B?K0gvTEV5T3R4dGJGYkQwREJ5b0xmQjR3RUZJU0xGTU4vaDNRR2lscFBQN1hG?=
 =?utf-8?B?cXR3dmFxblhVRXdqNVpLWWxvaEk5dXJIN0F2MGJ4eUxreDBVSnVTOElVLzRR?=
 =?utf-8?B?YXpTM3R2cG1vczFqN29KWVVqU0F4eUg1SHpnc0NMNy9waVdQbUJIMkZicnVF?=
 =?utf-8?B?VUh5YllpMTIwcFpsZDd3enB1R2tITWtvM2tiMld4QnU2TEl0ZGFTY2dpbzJJ?=
 =?utf-8?B?SGt1WmtWaFlOT1FidUJQN0sxWEZiWVFjazFyVGZQT292RExzb3lENU1RZUxP?=
 =?utf-8?B?Q3luUHA2Mmlpd2d0ejBycllneExJL290VGJuZFE4UDEydXN6d241aXZJWG50?=
 =?utf-8?B?TWllUkRnU2JYcS9yZ2pSRXRTUnZjUVFzeUp2ZkRyWmQyUjEwWjNTRHhuZmo3?=
 =?utf-8?B?V1VuaXN6R0NaMXVhRE82VGMxdThudWlGS3ZWbVd6UEVjdXo1ZEEzU29sN0RC?=
 =?utf-8?B?STgzUDNJWDVqU1M5WEhqK0xKNFlEVVFpelJWUHBFYVhsK1hObE4rcUlGY1Q3?=
 =?utf-8?B?SkhXL3FHbUsvaXJJN3ZZejMxc1pUbmQwS1dMOVZOT3Z5SkFwLzI0V09KUkVp?=
 =?utf-8?B?Ulk0YURQK0RVUTExbTZzdlBLWW0rQy9rdTRvM1B6aU9QMzQvc2hOTnRCTkhP?=
 =?utf-8?B?RzhQSUlvQXRwZkpQbDFsNS85bXNmL09ZYjhPdWlCclM0SFMweVp6VkxyTE0w?=
 =?utf-8?B?UFFqR1E1TDQyTE5Sckw4S21OYVpESU5VREk3NlBkNENxZGdBTDlIVWlaR0xK?=
 =?utf-8?B?dE9ldUVuTFVvd2xqU0huZ0t2YkhXalFpY2M4ZjNFRG1qaDNpTVhjNXAyeGU1?=
 =?utf-8?B?L0xFRXRFNmJpM3FEcmZGUDBoTXJIYWpoN3Uza04wQ21jQTlHYlZ0TVNVaDZv?=
 =?utf-8?B?Vkc5b3dIRkcxNEZmbXNIQlh2MGNIVmJrbUEzM0M2MXFuU1dTa09qbzV4TFNs?=
 =?utf-8?B?cXBxVWZkcWt3U1o3OWJuU0V3SDJRYjM0NEhUM0J1bkdyc091eVdJbWtNeDBF?=
 =?utf-8?B?d25rVHZvVUw3RXZvd1VoWlR1Si9lVmNIUjhBYWFoNGpkOVJTeFo4NXdXU1FC?=
 =?utf-8?B?S2hHa2tMMEJCRmR0bmJKdVlsTGVtZWxTaXMxODllbzR6MGFPOGF2NWUrbUpE?=
 =?utf-8?B?Z3A2SGRGa3Z1ZTNjVENMQTR6bnBPNFJuK1VKRXJYVy9ady83NVM4VFVmRitW?=
 =?utf-8?B?MmtDczNNQ3lhYmpNMGlCb1UvaGxtcnBQYVlZMS9KTGVLVnBTc1VpcjMxODFU?=
 =?utf-8?B?RkxTdFJrVVhFdnF1czA2QmV4aXE4MkV1eXN5eS9zdlUrK3g3d2Zna1Z0TW16?=
 =?utf-8?B?YVNTRzlzYUhxTXBnZS9paktSSENaUHc4Q1JUVk12d0pDODVEd0RENnZVSjZL?=
 =?utf-8?Q?uzOg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZNM0FnY1dFZWFrdWF6RmJGRGZwcUpVNG8zbnZoQ1NsdDFjb3BrS09mekJI?=
 =?utf-8?B?VmhWejcxSGNqenpkcU9tN214blg0L2ZGK0dzcDRodG5rT0R3aUFMMGIwMnRI?=
 =?utf-8?B?bk5XNTBMcnFFZEFtRmdRZkRRVThaT3g0Tm1tWEFTeiswNDlmdWNiQWs5dnEw?=
 =?utf-8?B?aWFGN1pSUkhkbFlxSzBhZGd3MTBOdXkxN2pwb3dOVERHa0ZDS2JNZGVxSXVB?=
 =?utf-8?B?bVQvOUJ3STVYUzBKZ2YvMUhBUURIdjM1MHlibHA4ejc2THZPUHYxbzNPTjZ5?=
 =?utf-8?B?bzY4QnlJdmJwZlJ1eHR3YVhDZDJOVi91eXVIaUhLZ3NwMVkvb3Y1eXpwek9Q?=
 =?utf-8?B?MFNlSmd6dVErbEZ3SXBTQTAwNEUzZjQxQXNFcEYwSkdWbmh1MXlnYlFxSWw5?=
 =?utf-8?B?enZ1eHhtS01QQlovN084UnFzYWJWTUV3dmpuK3pTRyszWS92bTNEQ3htSFkw?=
 =?utf-8?B?NFp3L2F3Z3hBaUZxY3J3TkdwaTZZRU5CZGkrR1phVmVzL0xja0xsd00wMkVP?=
 =?utf-8?B?dzBzdUlFa2RPbVdhMGZOc21DRmMxY1p5ZkJzbkpTbEVOc1gzN1ZvVFNCNXVY?=
 =?utf-8?B?OWRzdHpoODJTOFA1QlFza0dLckJsYnhEVTZlSTdjczc2U3djNXNxWHBJNlJB?=
 =?utf-8?B?M1pnMnFFQ0ZuNHFBWnllWDU2YWJPQmJPYTBIYnhRT1hYN3hoKy9MdEcxM2xS?=
 =?utf-8?B?L2hWS1hHa0dnME9Lb1Bob0tjMkdiSXpxRGVnc1VYV3hrZ0pyWVlLaHhjbUd3?=
 =?utf-8?B?VGdnQWNFakpjZ1JBcUNKZTVsUmVYYVdLSHFua3VKby9zTjJqLy9XK3lOZGxQ?=
 =?utf-8?B?UXhxenZtdHdhMTNaSGMwd2R5bVpnSVVWdmR6U1dmcVgrSWRSNlpDU3diN0N0?=
 =?utf-8?B?Q2VOMkF6VHZyZVd0ck5hWEhoSjlxSWpDMGt4MmNDN0N4bDdNS2l2VTdsdCs4?=
 =?utf-8?B?SVM0bzhDUUVEd1ErSlpjOXVabG14REZEdE1oejlFNmNSMUZ0T0hPa0FrelV4?=
 =?utf-8?B?VEloZUtWaXNBRE95SlNERWw5RUkzVm9WMU4zU2FNWUJFdnBhSWluRnAyc3Vj?=
 =?utf-8?B?a203aTBsMlRTcW9XQnR4dENVUFZndm1CTDBkdkpDK2EzUW1lWnBuM3NZNW15?=
 =?utf-8?B?ZGNGR2Z5QVlEY1Fzb1p0TlVoWlBEcTNMMHpxdzlGOE80ZTVHcFo2UkpLdHor?=
 =?utf-8?B?eTFJOFhQb2JMOXRTaU1tUkR0ZmtSK0NYbnQ2TFF4OGczUTBiVXNIRWhYdFJ5?=
 =?utf-8?B?WERmMmZ2ZjV0VmcxWDlPYnJKQ0s5eDNYK2pWalNsNEtGYmlmUzk3cVhKYVNN?=
 =?utf-8?B?Y09xRXVWYWVMR0orUU5pbGFxY0lGZEswUTNFMHlxTnp0VGZMcGZ1eUI3Mllr?=
 =?utf-8?B?bWIzcVdibHZ4SnlJZG50M2lFdjBrK3RRMHpMVmNUZk8rOTFFcmdOWVVhMXdJ?=
 =?utf-8?B?M2NKaVV3YnB3S0tCNXloRFVHZ3BtMy95blhQNVloZHB5cHhQWXVrOVJyR2pC?=
 =?utf-8?B?TEhwZkpWSjlRcUgycXFhMEJUVHhMejltb3Yvbk90SGhCYnFvV1prQ3JGY1hU?=
 =?utf-8?B?ZEFkV2c0THpPUHBoYnpqU3U3T3ZOeU15bFpjd25YTFdkZ0h5cUt5V1dxYUdt?=
 =?utf-8?B?dFM0Tk1kN0xwQTdvVmxBTDBzN2lIend5ejhhaTlvWllPaTVGbEUvMTR6ejFz?=
 =?utf-8?B?YXNEZnpxR3hMY0Q0TGhGMFVWNHR6R0pzT0RsNDJDMGRPbjhNNWhuUHhiTjFV?=
 =?utf-8?B?azN4NXNrZVBUSkNVcG5ZdkRRdTJnY1NNSUZVcDNURkk4MHkzbmVZbmdncTJV?=
 =?utf-8?B?RzR3MDVGaDZVSnlaMllKVkdML2J5a3dpSVZPeDd2R0xrYVNvc1NIUEhGWFpL?=
 =?utf-8?B?QnkxQThLOXdqcVhuc2dkUDNaQnNrRlc2KzNQRXJNN3A3ajIxdzlyR0dwUlRq?=
 =?utf-8?B?M2o4R3ZVNWJ6alVsd3h5VEh1ZDNsSzFWVlpPWjdJR2Z4WC83aXZpSHdReWh2?=
 =?utf-8?B?bU5mVEFLZzN0TytLWmYvWWxiaFFFaHdzNUQ2Mk9rQTZvNWRINWdXZXduRUNT?=
 =?utf-8?B?NFRNRFlkeVkrMlJQRnBZZXNuK0lTZG9iNDh6eno5eG90a3NWOVdUYUM2VE01?=
 =?utf-8?B?QTJZMUJuenB0cVcrWk5YeFVNK0xRa0g4ZnFLWDlWUlI1MVV3UHg3emtQdHJB?=
 =?utf-8?B?VHdrZkg2TlZVbHVwNDBvYnJ3UkFTK2prVGlIQk50V1NSYzY3aGVicWF3dkMx?=
 =?utf-8?B?a3pnQS8rYVdFb1JpN3hDR1FzNGQzWnpKbTlhSldlSkRTb2ZDME9SOE93ZW4w?=
 =?utf-8?B?UG45Sm41K0NtL2t2SmlkeUdpbWcremZaTUp5TTgwVlp4U0c4Ym9rcElxTEdz?=
 =?utf-8?Q?s3038YKgNCUeNSXU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc796ca1-f29f-442e-1129-08de63731305
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:25:02.6231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3MAYO02s/GGXLYo7hQ90LCkXfZ4h26Wh0noKMLr2w96UzB21otATVPFol4Jayg6nYDrG9WEiEpGh0jzSM2bdFyojmbf8z5+6qmZvbGm3nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7077
X-OriginatorOrg: intel.com

Li Ming wrote:
[..]
>  > > 
>  > > To fix this race, require that dport addition holds the parent port lock
>  > > of the target port. The CXL subsystem already requires holding the
>  > > parent port lock while attaching a new port. Therefore, successfully
>  > > acquiring the parent port lock ganrantees that port attaching has
>  > > completed.
>  > 
>  > Are you seeing this case fail permanently? The expectation is that the
>  > one that loses the race iterates up the topology and retries.
>  > 
>  > So yes, you can lose this race once, but not twice is the expectation.
>  > 
> Hi Dan,
> 
> My understanding is that would not trigger enumeration retry, because
> enumerating ports flow retries the enumeration only when
> find_or_add_dport() returns a -EAGAIN. but the port's driver checking
> in cxl_port_add_dport() returns a -ENXIO, so it makes
> devm_cxl_enumerate_ports() failure directly.

Ah, true, my mental model was still stuck in the old top-down dport
enumeration scheme.

So, yes, we do need to make sure that switch port creation does not race
port lookup. However, I think the scoped_guard() tends to make code less
readable and in this case hides the opportunity for more comments to
explain what is happening.

I also think, per that observation from Jonathan, that we can save the
cxl_bus_resan() violence by taking the CXL platform device lock.

So, please move the locking internal to find_or_add_dport(), so that
plain guard() can be used. Add comments for the fact that
devm_cxl_create_port() and the CXL platform init path need to be flushed
by taking the device lock. And explain why the device to lock is
different dependening on whether the parent_port is the cxl_root or a
descendant port.
