Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110813957E
	for <linux-cxl@vger.kernel.org>; Thu,  5 Feb 2026 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770253439; cv=fail; b=VFu/FjZTu44rOv1miZ5M4+ewKVbL3ahM8bYVfqL1HkqYGmxTVupXvYr1fs03LtXr59oYl2RCcatc4M2irMXlFeL2AkOHHIrJ/jgE/T/MzW8hpSCpyGFfYd3Yzl8QnrFr8NdYxEGENBs9eAH14Apal9ThUUWNCc3ISbSZDHK09PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770253439; c=relaxed/simple;
	bh=B85YrjXizwsv5Xs2vJQbQHpx4cwZfg/bvd7RD/A5fUo=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=HD7R2Gm4TWEkl2MOErHsH0LwXk7UZiznn7J+NBTnby1rvXQPg3NCuYQ9VdyHUYHfS0V9mHOH+iNygHy0E/11aPsnQ6yGn+j9nYyFs7bBCnr1Lzv6PloN6kOqsxIZJzmB4vyg/akfglJ1zc2ngI+YlCCxpz+Sfjkopy3/gqImijk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJ/dbi5u; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJ/dbi5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770253439; x=1801789439;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=B85YrjXizwsv5Xs2vJQbQHpx4cwZfg/bvd7RD/A5fUo=;
  b=NJ/dbi5u4l6NmdhwTb0aRtdvqaLmVNxkmOnNoKzZstMz618Sooz/CGQa
   B8VAedHkEtfhqc4qbr6Gq/s5dLLK+MsY64I+z1oVwA3isdbPOQ5RXyAlw
   ausE2sChS2StmLmJUistFO9P0A1+a8K+013DH2ag8v+8cehdC/fNozc7q
   ruvbBlASBfON04ITbw7mwbWlyWKu8Td3kxGHKFDVLIipZOoUnOTfkN1qs
   XWjFTOIK6iG88xZRFvAo3i6T/BM6XCpJ0NuHfps42eOCTKecZx+HPVO1F
   aHcFy069zYZAICe5XSQt5QsJFl0iWf79nYGqgZH+drtwlwwI79QYDXAcr
   A==;
X-CSE-ConnectionGUID: R/klcie0QmKbCJPmxZYYEg==
X-CSE-MsgGUID: VikSongHSd+28Am++Glxrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="59026777"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="59026777"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 17:03:57 -0800
X-CSE-ConnectionGUID: ya+wN3WJR6+CnL/tKr0uHw==
X-CSE-MsgGUID: I0qRR8cBRkWU9D80OELrPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="241029403"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 17:03:56 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 17:03:56 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 4 Feb 2026 17:03:56 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 4 Feb 2026 17:03:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1zp6R9+80/+sbneSqPHJdvxFuLbT63IYsrs0QRsFfEVN+h348cQNybT4B1caZ0XzoFHcqi2NMk9lBBEEj7i2M31crLXKgj/1vrqWI+b0ZlzjpAeFDW1v3YpPUKXD3uqEYxPt5pIfShSFJwXAK3wjkUmv3rVBqjJiEnh+izMQDw89qt9RW6VgyrfgBg7UBXipL1mnsyemI03aawx56OvMLQF7fBJcrn3jWpoDltXd5gpbWh1UJBKlcGCNR78FcPCLWWYBdGw2tqCyFqsJEnF7qHxfHDYx8zm38W0LlHDBy1S1WBdmKVFT7VPXAb3CVb+dtRKRyXjfPoAMQhAO0+AZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHGgT1NJJDlGc2/L5L1SvLA+kZ1y3LDFQHTnJouOwZM=;
 b=soSWNnHnc9wArIkQCD7yBIQgOYSt0uoJyIK8nu7FWV7rNgrFKF9lyRp09sKNei+KyBL+fCQoUuSGZxlF8HeQuGR145+8iKODHbxMHk2b4QhXXzS9M33/cSFoozOe6H21HWZbt23nARUaVgkhGMINGK2BuUl2wojISLY3z0iZcKzXtj70hCalvpHny0DuXNnLvQe8ZmRL0anKyXQsDn/CZUl3ls27Xq2tjzYcxoD/1N2WMUnyRZ7mRDEff7P8upWx9VEmW1qHlnL78jAJYeG/8tDeUKRM4K+BG09cWSmh0JxnxpxnhfuCt087wj/q9jJfGqENYG2FIyMgUlw99gRDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6559.namprd11.prod.outlook.com (2603:10b6:806:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 01:03:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 01:03:51 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Feb 2026 17:03:49 -0800
To: Alison Schofield <alison.schofield@intel.com>, <dan.j.williams@intel.com>
CC: <gourry@gourry.net>, Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
Message-ID: <6983ec75f021a_55fa100dc@dwillia2-mobl4.notmuch>
In-Reply-To: <aYPiMCuNQ2torvwF@aschofie-mobl2.lan>
References: <3bcc5143777acc6d45675d78dd8c57079406bc53.1769746294.git.alison.schofield@intel.com>
 <2a613604c0cdda6d9f838ae9b47ea6d936c5e4ce.1769746294.git.alison.schofield@intel.com>
 <697cee39ed313_1d6f100bd@dwillia2-mobl4.notmuch>
 <aX1VMDh9IY4eg1h_@aschofie-mobl2.lan>
 <6981668d2182_55fa10024@dwillia2-mobl4.notmuch>
 <aYPiMCuNQ2torvwF@aschofie-mobl2.lan>
Subject: Re: [PATCH 2/2] cxl/region: Unregister auto-created region when
 assembly fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 2910337c-bbfd-4b4d-51b4-08de64526d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?am1Rc3h2aUhSanBCeTBWQ1d2Zk90M2VPaEtKYldVMnR3QUtRZzdodUdzeUtz?=
 =?utf-8?B?RTN6M3QwbUFhQ05ZT2t0K2JTWHNvNDZRMlNVeVBsRTBCZXRPQ1BOUUpySERS?=
 =?utf-8?B?OFU2K1I4K0w5NEg5UXpSSkl3RzB6aXF0RlNHVFdZeVZrc3JweDB3Wktxbkpi?=
 =?utf-8?B?bEtsVTh5MDJpaGt4RkkrVnMwL1oxbmJMNWY0S2hLdTQ2eHo1RmpPYnFscmJu?=
 =?utf-8?B?U2I4VWNEaEFkbXFxNjJQblFaMW82N09wWW41enZoRmlvemhWbHRqKzZxait3?=
 =?utf-8?B?QTZhYksxOE5wU2ZoMUpEbm9sUFZtVnZQNEYwdTB1eFl3Y1lBLy8yVXdrcUFv?=
 =?utf-8?B?Q2I5L0Y2NTNadVN1Z3ErRmpDbzRIWGZCMTlHdWpEUktmdGNFVzNQVUV5Zlo1?=
 =?utf-8?B?TnYwRlFCOUNyWWMxN3N0TkNvdktoVXFXb2ZRVko3RHRXamJpd3dJb05jRnhv?=
 =?utf-8?B?ODdXSjdsaWtmMUovUnBRRnVKODU1ZDREWGl5OXdlYWpBc1BHN1ZIMDFjT2R0?=
 =?utf-8?B?anJlRnpGTEFpdHg0SmpwT2NJVjBUMHY1dnlHcFBJOW5ITUgrSGVYdDRNZlcw?=
 =?utf-8?B?cGdtcnA1RWs5RDlFUnlyZlVYSjkwZEJCZk5QVzNOQTVrVjI3U0RlelRQemVW?=
 =?utf-8?B?U20zZ09yZ2Jnb3A4N255UWsyY21tWHkvaFFCeW53ZnAwRnVHUEJzbGhGMTlG?=
 =?utf-8?B?UVlUZTFodDZ3L0ladm9RM2pzQVNaemNGRENhM2JhemRhV2RlWHNqczdlZFpw?=
 =?utf-8?B?bVh5dGhBeXh6ZkNZQlB1dlEwQVd1RGR3Vy9xZHBxclJETkJtTWRqZGd1TlJY?=
 =?utf-8?B?SnZzL3N2YkJjWW82ekE3VTRVQXpsT2xNK29HTlZRdjY3WmRGTVM2cjN0V1I5?=
 =?utf-8?B?VzU0V2lDZ0ZuYnRkT0RGNHhFQVIxNDV1UjlZdEpMamZSN0lQajQwTldvRjdu?=
 =?utf-8?B?bm5hc1pYUUdicTY2U3d3VU9Cd0VRdFFwNllpc2VmWi9EZnVLWkIwT0ZSM0VM?=
 =?utf-8?B?eSs3NEpUUXFjOXI5QktqQzRPWEVtNGVoRDd0UlE3UFR0eHBsWHVVVDNiMWgy?=
 =?utf-8?B?WHl4TlBWc0lZWkw5TmNKbVZFTUVHUkpXTFRCcGlTT04yN0hRUE5IcEtWUEFV?=
 =?utf-8?B?UTNGdWNFdnBubDVvMjFOUmpBS2hCK0RaUk85eHNaL05WazBTZ3dUNkYvVUFE?=
 =?utf-8?B?NE9xOThXbU1qTG5tUndOenhnWTFKc2todmZHOWxFRytuaDcvK0M0a0U2L3RK?=
 =?utf-8?B?dCt2RzIrV1d1a1gvMk1lOWhyRDExNTFHY0l4eW40WWdCSExEUnNxcDZieXRH?=
 =?utf-8?B?bFNrb1AwNGlQUXNwUE9CZkJNcWZxNmV6bmQ3VmJEUHM1Z0YveS9vOVJiSkFo?=
 =?utf-8?B?YUpUYm9XbjlGVjVCb3RuTnVzODFRaDZ0YmVqM3lUSzhuZVJiVzVuN1BickRw?=
 =?utf-8?B?Rkpha1VUMlAwVkIvN255ZzU3Q1ViUStYKzlSZnBEQnlWVmZpUi92MFI0RS9z?=
 =?utf-8?B?dFJURi9RczU3OEcrbFl2ZldnQVlOelovZ2FmMlc0ZXNqQUNBVFBzMWNBUERB?=
 =?utf-8?B?ZENUZGpJRURYbDlhdGNOTlRlMEU4ejdhbG96NFgveFRQUE9mT3dXZzFBN3Ey?=
 =?utf-8?B?OWZrUkNLL0N0cEhTTFdrQ3daOHZLU3lwUlJZNnMrVFBxdSszQTB2QTgwZzZa?=
 =?utf-8?B?SUFYTEU3MlVVUHlCVEpkU1o1bllVTk85Zm0zcXBFbFloQW14OVQ5TURLSjhF?=
 =?utf-8?B?T0l6VExMaDQzeHRGM3kzVS93V0RhMklNYmlCd0xYdFRCbW1qcTFzTVdPQUFK?=
 =?utf-8?B?c1hYUHRZS29EelBhQlFXa3hnU0pkWjk4WUl6cTBBRG1zOFBWMitXMEJkNE1i?=
 =?utf-8?B?dkp6eWEvVllncGVLeEM0ZzBHakQzeGhDb050UFhuaGVtQWllT0dYK1pwN2xW?=
 =?utf-8?B?MjJZa0sxNmd0RmNYMkkweGhmVFEyWkxUeGRoNXdFYk9OZ0FHTEl6anlxcDhs?=
 =?utf-8?B?aEJ1Nk1BdHIrbGxnSW51TDU0ZXpUSGdQaW15aGNMd1BjRUp0cjV0UHFnUHFB?=
 =?utf-8?B?QXkrNHdzUGVwelYvNzJ4V2JVVjZxTFdGU3JXaDNjTC8wWjB3OFR0SVI3TzJM?=
 =?utf-8?Q?dovvZUxUnSVjy9FRVf90Ohs9u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBvQ2trS2d1aCtISFBUaTNpZDc1RGFVQ2V6ZjVnWnI4a0NMREdDQWRReHQr?=
 =?utf-8?B?TW5xN2QwbCt2eWhhVUUzWXNQR05ia1NNM3FUdG9FVkYxdnZuaGdXcktJV09j?=
 =?utf-8?B?d2xSa1gxbnRaQWo3M3BnT1VNK1VPd3pEZno4WW9IdTFINFpTSU8vZUJFOEd2?=
 =?utf-8?B?RkJFRENONjVOWUQ5a0tyRkNOWWZFRzFRYmdXdUhGVnBoeVNwY3NTNU1TSFhI?=
 =?utf-8?B?VFNxSGc1V1JNaE81NThTV3ZBWkJQL1VXM0l0TTMyNjVxV1hGdGtBa0h5YklB?=
 =?utf-8?B?V2R3UHE1amVtNHJxSXNwZGoxcFVFM01YQm9sVmM4dmpqSGFmRzZVNTZWMjdw?=
 =?utf-8?B?VWlaU3VSVnJzcmlFSDlDcm4zV3YvNVR3M0VDWnQrQmw1ZTc1WEw5QWIyRDZs?=
 =?utf-8?B?WlpISFVEaW9pV3JSMGVFeHFTVUtHdHZCdGpTaFZlRjNYeW05ajBmdnNRTEc0?=
 =?utf-8?B?U2poYjVOOHdORXErWVN5WnkzODVUajMveXFzRzNIM29abUxpOVh3eXp0QTRk?=
 =?utf-8?B?cTIzd213SGNxL2YvcFBiS0ZmOWlyWDVKczBuVUVkSTJyVjg2NXRGMzNRWVhQ?=
 =?utf-8?B?QkRJNFhpVzRZTEU4eHpaTnM0QXJ1TG5BMmU5ZlVMcEtBaDd3bDBtcUZXR3R6?=
 =?utf-8?B?WWRScWF4TncvRHl1M2NwVmJGTEJtU2d5YndDOGx2SitRdU1ZcldjN0FRdjZV?=
 =?utf-8?B?V25mamV0MkZpY2ZjVDBna3cxRjdkK1d1Z0VvM2MxaVlFMzZZVEdEa1BzVWVK?=
 =?utf-8?B?VW5ORmkzWXQwbEVpam5tUU8rUy8zMlJTL3l5a2Q5Sys5NDhlREZuWEwydTZx?=
 =?utf-8?B?NFF0ZVNEak5id0ZEYnRENGFSQnJGcVpJQnU5ZDhxdTlpWHJBSW40S05XY1NZ?=
 =?utf-8?B?SXp0bnk0OXVNUktQZytzOVlNREZKL3FIb2NVcUtvaEFjckNoTFlGYkRBc1k2?=
 =?utf-8?B?L21jWDVwRVJMQ2NnSFJ2aUpRQnhKUER0b0htc1hkMStWMkRFdlZBQ01rSUh1?=
 =?utf-8?B?MWk1ZWFYSmMzbDg1Y25mVnc3Z2xqamdzWFVzbG1iMmtJTUtBaTBDcTJKNm9h?=
 =?utf-8?B?ZmJUdTJhOFNIM0hoMjlOYjVvOUpKQWRac1RmTGs2cE4rSWZFTVhZTkovckRD?=
 =?utf-8?B?aGtjb2tDL1ZzQXdXaGV6ZExSZ0pLYmFPTXZESWMzaUVSU2NyaXh1U05DSHND?=
 =?utf-8?B?NlBVSmZ5ZnFTdVhzV0tadk5walZrcHovdklRdjdlT3JwNEVvYURjdFNPK0JH?=
 =?utf-8?B?QXZ4N3h3RTRGMnBqd1JySUNlR2xSaWlod0J4QyswVnZUZlMrYnVGSzlSV0RN?=
 =?utf-8?B?a3BaRXhMWTByeTJmZDlWYk1iY2R3cndZS01JbEpSZVNxVzMrcTVla2JkV1lu?=
 =?utf-8?B?MUJabzRaSWpUTTJHKzlJY3dHeWlHaUhzZ2lYWHg5Q1F1R0kyNWJqWVJPZ0lE?=
 =?utf-8?B?MnhjT1dZUjJyTGFpVGtSUE5LQjMwK0ViNTdXVnNiSWk3TUNOVkdDYXk1K2Qr?=
 =?utf-8?B?NE04UHd4S2RaT3JoK0pMR1NtMGZMNjJjZHR5dWlpR1FoUU5PMVFhMjdIVmpG?=
 =?utf-8?B?VEEvY0toOU43U1FMVkpOZ3lsWUJMc1FKOXNPbjNaaXJuRzhyQVM5MkRTOExF?=
 =?utf-8?B?SlNSS3NnVFNPN0JUcXMvSk95d0tYNnJLa2VSZloySXlrRnRTdFBLOTdSY3dK?=
 =?utf-8?B?Vm1oa0gxMGFydTY4eEtXTy9wNEwwR3MzVFVHRlliRHhvYndVQTRFSlFtWXlM?=
 =?utf-8?B?Q3NHNlV2Mm5JMTgzQm1HUlJiWmdYdXdacFU3VlBrTDVnbU9GbC9IMDhQdDdV?=
 =?utf-8?B?L2ZzTUg0MkVOZFk0RXRzNllqMlVHdTMxZzlQNVVtVXh1VUVScHRHM3dHck5P?=
 =?utf-8?B?OGNBMmYyRng5VUxCOTEvVHhrK3FkeVNyMU42WlR4SnJmMms1d215OFpTQmxx?=
 =?utf-8?B?TmVrNUVxYktqdHl3N05UUnhHWTZnMUNVKzRJZkU1KzI1T0NvRUR0ZUVCd0Fm?=
 =?utf-8?B?V3R0Ukx6bFQ2Qk1kdVVQbEJXOVRmU2pNdDlla0NCU0UzM2FzUmZCT0prdVpT?=
 =?utf-8?B?amRoRWlBL1Q2ZkFCSytESzdmRTdxdnpZaG5NVVFOaVU4NkVNS0c4SVBzZ3Z2?=
 =?utf-8?B?eFIvOUwyOHM0aFhYMDNyKzh5Tm4zVW4vQVpMZUk3cjVYNDdQR2N0bUFCVm16?=
 =?utf-8?B?Z2w0OG5uQUxTSEcrK3ZjaEZEWEQweEhISDJvZ0R3VTBPMjBUVk0venV1R0Nm?=
 =?utf-8?B?aXBscmVsU05qeU8wQVNtRVZsSHRIZGFBOWNYRGNpclhxcERhRGZESnlqRXRB?=
 =?utf-8?B?NVdWNzVzL0ZnN241Nm03dVZFcnZYR1lSdERXN0NJNUx3aktuRlB1RE16K3R0?=
 =?utf-8?Q?+fwFMtl4H9TuSb/s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2910337c-bbfd-4b4d-51b4-08de64526d14
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 01:03:51.5350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 661MSvq1Zl87pE0c3pEzb45g6RXdtaW7rhJNkinXN7ZuE9QMalEYyvyaRvzq33kCG5mUk4p6btSDvV7D2nPmgbeN0CBdSoj37fMmtnlT5WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6559
X-OriginatorOrg: intel.com

Alison Schofield wrote:
[..]
> > This gets to the heart of the question of what practical problem is
> > being solved with this and is the solution suitable? Outside of the
> > "platform is doing something strange" case like "Normalized Addressing"
> > or "Non-CXL Interleave Target" I am struggling to imagine an end user
> > benefiting from this automatic cleanup. A system which is so flaky that
> > it can not arrange for BIOS configured interleave to stay alive through
> > Linux boot. At that point I expect the end user to decommission that
> > system, and flag it for remediation, not recover it and keep running.
>=20
> Hi Dan,
>=20
> Why is the response different here that with DAX failover due to wonky
> BIOS usage of Soft Reserved resources. When BIOS is unclear(?), we give
> up on the CXL regions and give all the memory directly to DAX so the
> system can come up w all it's expected resources, yet for these region
> assembly failures we are willing to strand memory, even though the
> option to give to DAX is so easily available.

Right, that is the question I had to Smita, can we solve the conflict
problem with less violence because it saves her series from having to
figure out the teardown race. As I mentioned, that was prompted by your
review:

http://lore.kernel.org/697a9d46b147e_309510027@dwillia2-mobl4.notmuch

> This is where you lose me. An unrepairable config may be safe but it's us=
e
> is limited.
>=20
> wrt the RAID analogy: I=E2=80=99m not familiar with md internals. IIUC RA=
ID tooling
> provides supported admin actions to stop, tear-down, and rebuild incomple=
te
> arrays. This CXL failure mode leaves a partial configuration that userspa=
ce
> cannot repair. So leaving the object behind is not comparable without a
> supported repair path. Aspirational, but not within reach like this
> soln.

I am interested in fixing those mechanisms as a first stop.

[..]
> This is not a unit test driven issue. It was not found in unit testing an=
d
> is not motivated by trying to make a contrived unit test pass. This was
> observed in real configurations where BIOS-defined regions failed to
> assemble and memory was not recoverable.=20

That was missing from the description that a real world use case would
benefit from this separate from the dax failover being discussed in
Smita's patches.

Are you saying the dax failover patches are insufficient for this case?
Is this an alternate proposal?

> Agree to call it a gap. Did I call it a bug? I'm not reading any intent i=
nto
> why the region was not unregistered upon assembly failure previously. If =
you
> tell me that it was with the intent that user space tooling would pick up=
 the
> pieces, I believe you and it's worth examining:
>=20
> Which will work better:
> -- improve the existing stop on assembly failure so userspace can repair
> -- or unregistering completely with a fail-over to DAX. Non DAX users can
>    recreate at cmdline.
>=20
> It's difficult not to be biased towards these patches, when they are simp=
le
> and within reach and the other is aspirational.

I think we have time to do the improvement. Deployments that want to
forfeit CXL driver operation already have the "disable cxl_acpi"
workaround. That has bought us the time to do the dax failover patches
which are nothing if not "try to get dax going after some timeout
(wait_for_device_probe())".

> (feels out of order here, but to finish response on comments)
> I agree the cxl list output is useful, but not as useful as making the
> failure explicit in a non-debug kernel log message, nor as useful
> as giving the user their expected memory via failover to DAX, nor as
> useful as allowing the user to create a new region from userspace=20
> with same resources.

If dax hmem attaches there is no opportunity to create a new region from
userspace, right, that resource is burned?=20

The summary for me is:
- If the CXL assembly failure leftovers can be made to co-exist with DAX
  takeover, great. If not or it proves too complicated, sure unregister
  regions. It is simply a bug that insert_resource() is optional in
  construct_region() *and* blocks DAX.

- CXL auto assmembly should be as recoverable from usersapce as manual
  assembly failures.

- If auto assemble CXL regions are not ready to go by the
  wait_for_device_probe() timeout point that Smita's series is adding
  there is no point in waiting any longer.

- If Dave merges this 30 second timeout as a temporary stop-gap while
  the "wait_for_device_probe() fine grained failover work" plays out, I
  will grin and bear it while grumbling something about the "disable
  cxl_acpi" workaround.=
