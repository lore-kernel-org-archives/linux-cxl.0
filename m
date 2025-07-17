Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9C1946A0
	for <linux-cxl@vger.kernel.org>; Thu, 17 Jul 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716997; cv=fail; b=Fia6N9k96LbKIcp3V1kANKi4aPnhuCojq3LUQV8+w9HDOtiQXnZwu3jD1NS3PLwLH+Xg9dM/Fj/eicgX5R2Tbt9thrxVtL6RDH6NNsVamvUAGwmuVoItdzwmG4LXU3gHoB6lLlio19jTFb4FsZOhAjMAjH4UQTvR4DyMBNvUkaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716997; c=relaxed/simple;
	bh=9+2ZOgqXxwgHAIiyFzsFqZ5iFc/LMatbc33oi8gSAQQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iyvZv0HLaGu/GFwFWFE+YeITHknU/+MIqXy+CvyotUIosNiJ/n7aFHI0/SZBgIAvpKSn5OiywxrZy2cZcHgjuvnWha1D+rMRqgD0u3A251h8TkoEKs80N55fMs8bqi8jcaNESd7G12jTlMA4L1vDVI/L1+hoXCz9/toKtj4fEQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvR0LTtr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvR0LTtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752716995; x=1784252995;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9+2ZOgqXxwgHAIiyFzsFqZ5iFc/LMatbc33oi8gSAQQ=;
  b=TvR0LTtrvLuNxKDCV5zbkINKYq9upTUx+sZ8x0rnaGSjRKVeMFCgWx4s
   p629EbrRPV3aJTYEaemRd3jhT43aLP/kpwfbYcobBpzfEjrxRxZKatO2z
   Z7aB0De6bJIyXS3RWUAZX4AGXgOQwDGR4x+NKWT0Rx8HcNXh4hc9kWsDi
   qPUxa8vYXexQfIvA/+4RzrCFa5dKOT8WSs/VCBYTxCjqUTWlYlZg3IHRH
   KGK8IRv2Mbqt2sXSBNS8oOsgYnV/aFPUGJGg4i4vV44xuVcFesL7yhFmB
   tgw/v8RmU3EncaC5DPZqNogtSmHYFkzBBHga+ayQQjjfzXFzTJR7XH96S
   Q==;
X-CSE-ConnectionGUID: 4HmZd+W0RgCIjglQHBvvfQ==
X-CSE-MsgGUID: ya9l0wWTRX2Gt0AHW2Ii9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54194464"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="54194464"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 18:49:54 -0700
X-CSE-ConnectionGUID: NhBspnUlTfyIOXASG0ZJcg==
X-CSE-MsgGUID: PMh5CtrISL6dGyaG0CEyow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="163193231"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 18:49:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 18:49:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 18:49:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 18:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIR9z1zUGXr3YuvxgwEe9NTUO/0R1XMynrWvSk8H9NCa/1Wr1LKchWHML8nWjVuEcFVOtYnpMlZC/VV3ZBIBMgwtbd9NIkCTyx69E2YQ5uYfS6Dxt6xCzx9/eZZpqVCAABa5VftMJE7emuz/FWO/QuQ+NYi5b6+0/1PzvR4J6BYUnHOkUL+xKA/99RjkVaH6p+PfKzjkU4NHxbpB8j3p7Us/dN6qgm6Ks8iKwNNwmTdlGlb5+MqeQhpBSjHiLCDRkpx1NNNYOl7L/TX+bCPvza8qmBFn95BHt6ckSN549XVWwk6qxG6TqSeyo/2by3t7J21ZdHnQUNPNFPeZ50mRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyBwU+hm0/Oy5k0jL+dcLOkAbIsBaicgzea91DUMntk=;
 b=pVgh3KQKjzBM3ZB7RUujJakAwz0U4t6+C44BAMmjBbpjw1w0TtDqOOLx2zqeZwrCr7USYmhmhKJvE8dFDb1kECziMD9yQpU6bXz3WB6ycCK1uxfW1TusdkxL/INTz0zgCqqegmTcnEZi5+149gxw4MQzp4e9ui04nTcNftHLp+OCsOLVsK7YLczWbMDYU0uxqd4jdUxPBHNZbcRS8SuSSQWmZtLIKuq9/TQKCFi0iRxRo8EnWYYBn3TgiMQLj5oG0ZQoHbv/DVaw1jUGmBn5Z+VFaYvnxB99+J7b3ZSFzwShl1RDx3GLG97spgzpaFJJOKiUTdwTSQkjCqz+TgokTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4645.namprd11.prod.outlook.com (2603:10b6:208:269::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Thu, 17 Jul
 2025 01:49:20 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 01:49:20 +0000
Date: Wed, 16 Jul 2025 18:49:16 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
CC: "'dan.j.williams@intel.com'" <dan.j.williams@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Question about Exact Match Requirement for Switch-to-Endpoint
 Decoder Mapping in CXL
Message-ID: <aHhWnE3ETrl_rZjL@aschofie-mobl2.lan>
References: <OS9PR01MB12421AEA8B27BF942CD0F18B19057A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS9PR01MB12421AEA8B27BF942CD0F18B19057A@OS9PR01MB12421.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4645:EE_
X-MS-Office365-Filtering-Correlation-Id: c6c9d3a3-dde7-42ab-1911-08ddc4d42576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckVmTGxlaG9wNXk3b0ZtckcvSzUyR1VOSm5qamF4eDlNYWlMamlYZEpUdXgw?=
 =?utf-8?B?S3ZBeTU5cVc2Y0ljQk8zZkJsTnNYejVwcVFYYTdvMng5ZUJiazVIUlpMNUlo?=
 =?utf-8?B?SWFUaXVSL04zUjdpendxT2xPZzNZNnpTZlhSaDN6NTU1bjZ4c1hSdXFGQnZK?=
 =?utf-8?B?T3F0YXg3bW1pTzJHR21LVStSdlV3ZWVIV0wrVGxkeTRVVGs1a2JtUFNVbzJP?=
 =?utf-8?B?YzNmbmVkUjBiVlNaODNRQmYxSUZXb3lPallRVGxBWWlSNzMyWDF3SzV1bGVs?=
 =?utf-8?B?Ti9BS1NzeDhjM1FRNTZjdEdhK3lyNTc3N211RFBicHZqU3ZrbXB0cHRIeUlG?=
 =?utf-8?B?ck42RzdMdXNmZGl0SmNDNldNU1FpbkcyVnZTcjhhdHpReEdOT3ZkcnZhaEhp?=
 =?utf-8?B?NlluS095Y0xJN0QzdGJsT2pqbS9iUCtQcjVESHR6akI3OE5KV2FSdEVya3N2?=
 =?utf-8?B?OUlqUmhCYmVTWS9NS2Y5eUI4bWxjUHFoRXJ5d1RyY1VDYjdaZUtmUzYwa3lC?=
 =?utf-8?B?clZqditrSThQN29PbGd6am5MVnB4R1dhKy9kZ0dIM3FRZmVWeDgxR3owZnA5?=
 =?utf-8?B?SjErUnRDWDMxaFAwbGExLytoeGRJazJ3Vm9mRXVqb2o2b1R3YXJHV1pvY3VQ?=
 =?utf-8?B?dFNzV282bHBsNk1BeitLTCtnUlBENStiYkRDTTlpQk5DaVNaQjc5UWUzVExy?=
 =?utf-8?B?VDZoVkpYTU9mQlZhcmV5eGcxUHh1Qzh4V1R5TlBGTWtoNnltREpqcU9EQzZY?=
 =?utf-8?B?WkhTMGdVWXBsQmpzTmprTDFicEJPN3pXY1g5ckJYbGlpZ0E2TkE4WWVxdDBy?=
 =?utf-8?B?VnVrbnA1c21lTGxwUXpmd1c3eWE1bGp0Q3RvNGJvWVhXRFlPNmNOWlBrcDZW?=
 =?utf-8?B?N3VYWTVPd29vaVlzUDZURHhaOFF2cXB5NVJjajhsRXY0VUl6akZ5ZmpCT21o?=
 =?utf-8?B?eHB5Z0dweGs5Uk55ZkVKNk5QK0hYLzRhc1lUOW15ekpWREx0d3J5SldFeVNG?=
 =?utf-8?B?d00yc054NUNCTWM1NjZJVy9LWmp5TTkwR2RrVTd2Qms3bS9LU1lwdWl5NG91?=
 =?utf-8?B?SnlHS0xWN0g2RFBqZXFscjZPejQxT1N3akZjcUhOQUwrMUpzSC93aVBIS0hy?=
 =?utf-8?B?QmhNSnVaMGZvQWsvM1VrM0pJcTkzT21aQUFwQjRWSXF0NkxDaDlKU2N5bUNt?=
 =?utf-8?B?WlpWS015NFAwWnNWdHNpMXhIZk5sNXBWVXRGay90aVhKZmsxQ2VrZFRZTjJS?=
 =?utf-8?B?UENpOE5ITitJWnRORnZ4ay90aWFvTmJKQTA3NmNpcTJBc25hS1RtRnd4eVMr?=
 =?utf-8?B?d2hnWDVHQWdBVnhuY2VKc3diMlpWdjBlckdHWk9RWHhsY3NCWk44U1gxSXhV?=
 =?utf-8?B?UGJiejFHU055OVZzc0hiT2NtREVWWG9BTGw4Ym5XNS9KdFl6YXhBb05KcDRR?=
 =?utf-8?B?OFc2djVtOHNSUUxadHFKYVJ6aFJXYkR4Y1ZlamNlUVltSjhxYWlaUFNQd0p2?=
 =?utf-8?B?YUY0aURoVmdVNVg3TGhYNzBOaXl1Y0xmV2pZVERLaUZjV0xhdXIyTStUdlpI?=
 =?utf-8?B?MTk5SU1WVVFPS28wcGZIN1ZJcnhyeC9oVllvNk1MTE5GTlB1QjVjc0hvVW9S?=
 =?utf-8?B?aXlveHNZY1BNYkdTMytzSE1ReHZOdDlJcktGNVdsRW44Z096dS91NWkralBI?=
 =?utf-8?B?UFRqN0dGUEd6VTV0T1dQVGlUbHkzWjBZcmhyc1ZrdkJwaHBmRU9Uc3FnaDFT?=
 =?utf-8?B?cm9ENmpIRTkzQmhTMHgyemRKdWxUdTNUa3RKem5pOExXTGFKTElDdXg1NU9O?=
 =?utf-8?B?SkUwRHdwWW9iREthV291a01vdnJna3dPaENJTEVVdGk0ZnlrczVORm9PTENv?=
 =?utf-8?B?dlMxY0t1Q1ZvTnZtYndLdGdKSnVKSE15VUdoYU0xN1NxdEFvQ2doL2drUmJM?=
 =?utf-8?Q?miKRsohqChs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eks1OEFLaGovZlZ2TW11V0xXYWU4RTE3YjJpWDRHSnpJRjBVUExoV1VzdHVO?=
 =?utf-8?B?UHc1NWZwckxYNDNXbUU1Z3VZQnh0d3U2UUdYaTFFM3FlY1R5bXZCbWk5Uy91?=
 =?utf-8?B?aklwR24xUFQzU0dOT05HakRPY24zQTYwNlZjbnJyZ1BCcUxyMHVxUVhLSHdC?=
 =?utf-8?B?TGFBRHl0d3B5c1p0WGxWVllzaEUwOHNsL0FyQnFPTjBOTmErYmYzSVFQU3FB?=
 =?utf-8?B?ckI1Y2lNN05kVjgzejA0UFBxek82UnJJYXV0eU4vYUVXSFdzbzE0QUxJekVy?=
 =?utf-8?B?TWF4UXdYNkhYZUs4bzlodEp2d2lHRlBLWm9WRktmVSttZVNwbUl3SHh1R1cr?=
 =?utf-8?B?QWxseEVjRmZXVktRMUlkbWZBU01JWEJ5MnlRT3JrQ1pTRFpDZE5DM3dvOFhZ?=
 =?utf-8?B?Nk81dXlFK0JLanJGcTRTSlFXdUUrNklIOEJqbzRnZE9TZlY2R216ZncrTmlR?=
 =?utf-8?B?clhFNEdLMzhuWS9LdDd2Q3JXUHp3Z0dBOGNFNS9mRnlQeEpkSS9obmdiTDM1?=
 =?utf-8?B?Q051b3FUdFkwTEtNZWJQSkoxVE92UEhGMG9lZ3Eyc2xNTVRiVVVpUXozVDlC?=
 =?utf-8?B?VE5DWTlwc3FVTnYrN1pBZjFzNlJZQ0FPYXErdm4ydzZZTjVwVWpSU1RWYThI?=
 =?utf-8?B?eUIrcEFtdmdhSytwditIN0ZnaFpSaUxHMEZ4TFV6bnZwWGpKTXpqbjBJMW5E?=
 =?utf-8?B?cE5ueDNJdEVuUVFxd0tzQXd4Y0hIYnJTRVhmdExnY21wUi9oZG9RK0twbGhQ?=
 =?utf-8?B?Uk1oMnZqQnp1bVJ5R2tmaUl2Y2dnU0ZieU1hSXY5QXYvQnVCM3BSUG11dkxp?=
 =?utf-8?B?S1FORXZ0QUFwWDZYa0o4YndsczlPanRyNnFzckw1ME1iekcyZmdyUCtCaWw1?=
 =?utf-8?B?Vk9xL0g0YnE1OXBvdGMzOFpPMkR0WmhrK2pMalY3bnhTVnNWMmpaQTdWbWE0?=
 =?utf-8?B?V3RUemovYXRXRkxJU0RiTmtvZGdyMnJqb1hzTi9QQmJRSCtHYmE2Q0RoN0JZ?=
 =?utf-8?B?a010eXl2VWNPTnRsMnE1dEw5WDc1ZUYvclBZaEpMSHQzYjNIQTFwUG9yVVlz?=
 =?utf-8?B?bVlQanFjajhrTGhMamNRaW0rbi8vcmswVnp1bkgwd2xFUGdOa1pCM1pZT0Q4?=
 =?utf-8?B?WDdXT2Rab01ic01CcG1zQUU0bmw3Vi9UdERZZzRub0I2bndyaE81SDdiZ2lr?=
 =?utf-8?B?Z09WelY3dmRkNVFLbU0zN2R3NmMxNzd3T1RqbjNXelF0dmcvVFhrOHV5Sjg0?=
 =?utf-8?B?bFpoMzl1aVQ1Vjhvc0Mzcy9lM1VyNkVJKy9YUmJ5Ykw0Mlo5SzRHTVVZTkp0?=
 =?utf-8?B?SXBHRDg1K1BHTGRwL3dIQ2RNc3RnbDVCRDk0bkhLMG1YZjJPSmx1MXJLUytQ?=
 =?utf-8?B?dld0cTdGY2s0V09qT0RJUkRaLzhHQ093ays4aXJhV3VPTjlHTkYvcmwzcW1S?=
 =?utf-8?B?RHFpSHVPRko2WXIzZVVGZ0lXQ3QrNFFDUXJUYUREVmNTSXdlLzB2aWhXMWVy?=
 =?utf-8?B?cEQxcXNNTEZtVHMxLzBGcFl0Q0ZWUkp2WkhmcldyOExFcFdWWVg2WGVWN3JX?=
 =?utf-8?B?SW8zdlZ5N09nYVBadzFQZU5LZjFpdXhCbTFxNHBNdGc2aWdkNnBFWVNNVTg4?=
 =?utf-8?B?bXdTUDZpZUNXUjR1UG8yZkZYNy85MUpRR1FrWU56Um1yQnp3cldJS21uM0gy?=
 =?utf-8?B?SWJhekpKY1hvdFRlZERydEwrc3JsNzFVQlFaVklXOExMbERrdW5IcXgxV094?=
 =?utf-8?B?U3RRZ1JqL0pqWjlmd3MwSFB1Q2dyVzdsNERudWhMMVZyTWZDNE03T0Y2Z1Fa?=
 =?utf-8?B?R0lSbDlDalhoYU5nejJaQmYvYUZ1RUVzVHZMcDdUNUVGMldlZkxBaVJOR0pU?=
 =?utf-8?B?M3oxSURHWm9VMFNhY1dLR3NMeUFDc1RveThOZVVPMU9iMmJZKytkcjZxN0Mw?=
 =?utf-8?B?NlZFMTN5Njh0Qy9HcmVSb0Vxck1KOUlvQ0RCSzlUTXptRklaRCtVNjQrck5O?=
 =?utf-8?B?VE54S2dnSTU1S0xHcDh1RFRQMkNjU2ptaEh4K0MwNjdJeE5wMVZaQmJlbm13?=
 =?utf-8?B?SjBwUUYyVG5OSC9aczFjZldkK0w3b3RUVmdjNmUrZk5Bd1VKUENWVGh5S0p1?=
 =?utf-8?B?SEE4QW9MRXNndUptWXBNdUx0bDc5c1gwTFNWU0ZYV1ZGejdaV3FZUkNZQXo2?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c9d3a3-dde7-42ab-1911-08ddc4d42576
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 01:49:19.9419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDEPTLDW+/rY0H/YvY0whLjRBqpIQEQEmtdwlD0BaLahm4MwwZriFBL7pyUSGqhyZfU1BbpQ6UI0lH/fd2SmoH4dDhbv/xf4K3ri26VmS4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4645
X-OriginatorOrg: intel.com

On Tue, Jul 15, 2025 at 07:51:09AM +0000, Yasunori Gotou (Fujitsu) wrote:
> Hello Alison-san, and everyone,
> 
> I have a question regarding a patch with commit ID 1110581412c7a223439bb3ecdcdd9f4432e08231,
> authored by Alison-san.
> 
> The patch description mentions: " Require an exact match on switch decoders,
> because unlike a root decoder that maps an entire region, Linux only supports
> 1:1 mapping of switch to endpoint decoders."
> 
> The code enforces this exact match for switch decoders as follows:
> 
> ======
> +static int match_switch_decoder_by_range(struct device *dev, void *data)
> {
>   :
>   :
> +       return (r1->start == r2->start && r1->end == r2->end);
> }
> ======
> 
> Could you please explain the reason or historical background for
> why Linux supports only 1:1 mapping between switch and endpoint decoders?
> 
> In our CXL memory environment, the CXL memory has two decoders connected to a switch.
> Initially, we attempted to divide the address mapping for each decoder, but this approach
> failed due to the above limitation.
> Consequently, we had to disable one of the endpoint decoders and map the entire
> CXL memory address to the other decoder. We would like to understand why we must disable
> one decoder in this manner.

Linux does not support assigning HPA slices to different endpoints
behind a switch contoller. Linux does support creating a region that
spans multiple endpoint using interleaving.

Looking back at the commit you referenced, let me clarify something
that reads as misleading in hindsight. Saying Linux only supports a
 "1:1 mapping of switch to endpoint decoders" implies a switch decoder
can only connect to one endpoint. A switch decoder can absolutely map
to multiple endpoint decoders, if those endpoints are part of the same
interleaved region.

You want to do this:
Switch decoder maps:
  [0x100000000-0x140000000] → Endpoint A
  [0x140000001-0x180000000] → Endpoint B

CXL Driver wants to do the interleavng for you:
Switch decoder maps:
  [0x100000000-0x180000000] → Endpoint A
  [0x100000000-0x180000000] → Endpoint B

So, yes this is a Linux driver restriction. 

Historically I believe this is for simplicity. The CXL driver doesn't
have to deal with partial overlaps or fragmented switch decoder coverage.
This give the driver a clean way to verify the interleave.

Can you share the bigger picture of your config and why you are not
choosing to create a 2 way interleave in this case?

--Alison





> 
> Thanks,
