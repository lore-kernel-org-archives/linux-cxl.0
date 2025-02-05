Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6479FE;
	Wed,  5 Feb 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746071; cv=fail; b=R0hm1cbEhj9yDcZ1WF5g6T3BYKAqap+CWtAFKFbBn+tQwbXYjnn+UR1S7JzCsQVB9qG8qEuE6rOi/4MHJPBrbh8gTaFPW2gOoWDltPhH9HrJksLhKOzyW0+H0M8JUYEgI9deO+stC1+kbO2d15P5CF6QIzj91aw8zAEef3rmub4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746071; c=relaxed/simple;
	bh=QJt/oX2RI8k/LTpdIUb0PxQJ1rs7mj1WyWea36wNsqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tb2apTAv/Edof05C0IdvEDuD8M2G3pVq7sTpc8Uqo9MY8bke5ViFB7YyBo11hKDM8BXzDHdpWeDd/S6putLKLqDYDGbHXR8wRBh8e87N82rDJzu/46K8TuvyMacU6yMa/o5nPS5IRNbFci7k4/Cq9PorlX6p5MnpiBWKkifiXcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lO0Tl8k1; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lO0Tl8k1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCQ492LesXqo65MX1ewTfZYS+8gAnQyFALuBp8d3/mEFA5xEjx7qsSChTTzCbWtRFHl0rTM8L3EZ4M3zPGlOL2dbCZ9w+eNrDHnCymAvpDMJlD4JUQv7gGIC5v0KD6O0R6KjMNsJNxXzycM0VgikaGiqDS4JPRlqHHN/c/gkY+fvsqN4ohnaz+Ibet53iPCSZJYEgpkAUutxkzztWwkW8sUin4uNbrRySEYqN+LXyseZoN6LdDnXewHz9G0/uS0TW2l39HwsA2Yq7qww3MgcMXw4uM/5GG9gNUIEjC26qH9W0sI0rSZhPVs78md/dDmZDwu+GT4rL21ZBKnN1ldkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jog7wmNBucK931tz/Rp7fzdNzTnLiubbmZyMxj+zcNs=;
 b=Nikvd66Hdl0+Haa8Z8mdR3ere38lWp9wEKuGKH1YiB316SKp+pzSyDiNY53pQb97+hEVszLKbZ6FFSMNIrqHvwTx5ONnnJPvDjnxeJmgpMqPEM58acgMSoZKOnm8IvKxEIaRnTzmowOjT8hNhYaexsSbVoFhwjWVz/6bPgKBoZJHNyu/yOy2OgpL3Isld934M6G1lPJ1dSk4/62+DJaR1ZkA8y9l9bT72BTxky/TzCh0JxKp140ehLRuxIcU/WI/pAafPZ3P26Zj2g44XklrLRSuNyLR8LMzqKVlg723aFUVX7dF617wEeNfLzGlujIqMHo4lNHSAzASVUXly/MfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jog7wmNBucK931tz/Rp7fzdNzTnLiubbmZyMxj+zcNs=;
 b=lO0Tl8k10sY6QFIB+JLNBFoX9i80yH3JyaTmI+ordTuBEG+435QmJmcJC4JSw4BV71pxFGntPafkCl9C9ppo6QY6B03YmtS5Jw1XVlhJ4P8wBou2vaDQGchtGZsUV6ZYFmGodFTMZiUPIfhY/muW678w1avRRnzsTXKY4OwIXBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 09:01:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 09:01:06 +0000
Message-ID: <445fa543-d83a-44a8-b88d-84be8d979c43@amd.com>
Date: Wed, 5 Feb 2025 09:01:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
 <67a28921ca0b5_2d2c29434@dwillia2-xfh.jf.intel.com.notmuch>
 <67a2a4d2519_2d383a29411@iweiny-mobl.notmuch>
 <67a2adbdde7c6_2d2c294b5@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a2adbdde7c6_2d2c294b5@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:550::33) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: e37dbc0d-d8db-4808-4933-08dd45c3a02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TENYRjhtM1VhTUJmYzYrMkxMYzc4cUJiR3NKM0FJdkNrNU5YMU91dk5hNnZo?=
 =?utf-8?B?S0lQYTNCbExId0d2ZzhVdk4yY3JZU2lMRktFT2MrTW9YUTFkVGZhL2lGc1VO?=
 =?utf-8?B?RHJwcHVKTEpUZEFWMXBrL1hvMWlZOEhUa3UwUFhVb3lreDNJQXhvcm5QNEZD?=
 =?utf-8?B?Ky9sMC9HWXZLWkpKN3c3VFdOb2JqT2RqUmJjU2dmQUkvM3E5ZG40eDFabzFS?=
 =?utf-8?B?bnRtRU9YYVBXKzN5TjJSZlZOU0JsajcvWnljdmk3VU9WdldNZXBDL05NRDN0?=
 =?utf-8?B?RW40ejZNS0lSNnQ4L21jNGk1MGd5enJ4Zy94YzZnbmZsVW1RS0RPbWFubnQ2?=
 =?utf-8?B?QzdmSlcxS21zTXhnUTJEVmJoclRjbTFOU3FGcGhzUC96dWErYjRuNHh1STVI?=
 =?utf-8?B?TzZ1cFNqbHUwU2taeUhUVmNqQ1RKeWxTcklXTldhZ01nVTFUYUVYRHc4Y3Fm?=
 =?utf-8?B?RTJkSjFYM3NZMWtrS1RFdXpqRWtlR0xMaXVGTlFWS2g0RWZqOC9laUFWSTNQ?=
 =?utf-8?B?UkZaNEpzaFRvUHBMbnNlUFEvVEhmN2JSK0xDQmU0MlNqYldFcjFxQzdhbkxv?=
 =?utf-8?B?bmVlcHJrSGg2YlNncGlCUHZJUXFOeXlRS3JMdXRlM3RXdTFSRWxkd3VmcHo0?=
 =?utf-8?B?SmpZeVZNL2FaYlZ4QXBpQXdUQlhhZG54Qy9uUk81N2ZIVUxHNHVhQnppcDhv?=
 =?utf-8?B?RHlzM0YzbnhRVlpyZVh4YmdhUFVCNFFoY2p4TWpUa21tSFFUVTdJS2tQU2lJ?=
 =?utf-8?B?QkVNRjdYR0lMK0tqVEZkVThweVV5STVySDhnV2VpRzNVU3Ezc0VWSU1QVTBX?=
 =?utf-8?B?WWtFRUJpaVJacUJ4S3huOEZWS2Jid0prTXlXREJ5c29nRUlNcXlnUEphcGdw?=
 =?utf-8?B?d1dVdWNzb3JFQWkrSGlOTHVHbUxiV09nVnNhMzdYaVc5RUVLK2xpd3hiWnVQ?=
 =?utf-8?B?TkhsdXFpQzBmTDkzMkJMUVkyS2NvWlF3U3RvdlpZcUxYMkRVZktCZlBlZFNt?=
 =?utf-8?B?S0orVUV1aVE4d0ZCODIzck9sR01ScHN0NlZ6dTh6WTE3ZTdhcS9oVUdJR1k5?=
 =?utf-8?B?bWhianR3SlNXU0hyd3grcTJVb2dzNGJ0VHpWazMzT3FYMUhWd0RtSGVQL1NH?=
 =?utf-8?B?MlIxU3NJNHpEWUFZRTU0VkpvRFIwbFRHcmVXWk4xQkh3MzJrWk5Ld3lyUWto?=
 =?utf-8?B?QVZVeitXYWVVUzBFbkJaMmp5WERuYjBWa2NUTVlpc3FCeHFITmEzYkg3eFJL?=
 =?utf-8?B?a3cwTk9UVVBsRVpQeXVBNlZoZGprY2I5Vlo0Ui8xWTZYTS9YVlNlYnJuUm43?=
 =?utf-8?B?Y2RqT0s1YURRS1RqcG9vSEF2aldtL2c3dEhLdFQwOHZGZ2NRSjVhM0lHM3lH?=
 =?utf-8?B?dk9uTDltL2ZJV2xZLzU5WGlMek1xTlNjZW5lZWlJRTAxTk1sRjFXcjFBOURk?=
 =?utf-8?B?dGNjTUxxWWlHOXRJU3Z2VjRwbUpWdTRvMjVYTlllZkhyc05IaExlNnJMcG05?=
 =?utf-8?B?cG1pYU5TQmN3YkdTNSt2WUNYcWlYNGg4VVk1Z1RBWURlWDZzb2ZxK2VCbkx4?=
 =?utf-8?B?K2RjQnRHU1M1Mm4yalFWNW0rb2s5VW1GbG4xbmR2SXVkcjhqTGs5c2xwdDJ3?=
 =?utf-8?B?ZmNqbnV0Q242NGVETDdCWVo0VEhhc3ZIN21hRktvWnRhRlY3VklySDdKajIz?=
 =?utf-8?B?ZXRqVnptN1VwcUdtV2NNS3oxQ2xyMDlRV2s2V2JOU0dZOWVtOEdpUXZMYWpM?=
 =?utf-8?B?akZoRDRpL2hucFFhMUpkSHNzZkxLeDlmTS9Ubkp5dWNJdXpKc0tKaCtnWjBF?=
 =?utf-8?B?aUZRTHBRRmtkQXo1N2F6akpWTkZPVytXbFA5VGZVV1lkQjRFSFgwVzZOMDB1?=
 =?utf-8?Q?bCvk3akAgkTNG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2JNM296OFZsdUxtMmF4TExIQUN5UzJEVXBJK21UUE1YejNPeTNWanErWUlF?=
 =?utf-8?B?VUNIQUt0UXV4WWlWNldQdGNqcHhCb3I0QnhVUnpzWXEwMUFOUGpoMmVacHRD?=
 =?utf-8?B?eno2UkJmVUNjZkx1T0RrK1BrL0pQQ3dkUHhLcGhOd0JMbHVvSnpBenRyWjZj?=
 =?utf-8?B?VFpLOWRpOU9Pc0JHM2RqWDFGZXJ2eGIxVDhtbDhYVWxZOURsdVNnMXJWZ3N3?=
 =?utf-8?B?UVMzYkpwaGlyY3VSNGdjZ2RVRm5rUExYWDZrWTlCM21hdmxhcGs0cW1lR04x?=
 =?utf-8?B?dHF2N1ZRNHdxTndvd1RXQ0JuZDZtMXZ2SzU4M0JEWVNmd3EyL0N0K2pja2Z5?=
 =?utf-8?B?cTMvaHhWdUNKaFE2QlZ5NHlrRFNGbkF6M2h0U244NGp4c2dxb3RUM2pjUWdv?=
 =?utf-8?B?ZUlWNGh4Z1dpSjU2NVFDVWwvMlNhQnNVVkVjZXAzMlJMcWQzcU9ScHR4ZThq?=
 =?utf-8?B?TTBmN09DTWVyb29La1pxZVFqWDZxRmlmTXlBdGdFUUxwSlY0NGcxVjgzRWZj?=
 =?utf-8?B?VW0vZnZIZ09yWWtJUThJclVDZXJFbG5aMFhMdzNRVXZaUjlqR2I2Vml0N25M?=
 =?utf-8?B?cFdENUxMTjZLWkd6b1N5b1BHRjljcVlPcmNtR2xjS213azZqM0VCY052ZjE0?=
 =?utf-8?B?TitKQmlWbTBiS0s2QWkzdUhlU0tEMmJWNFFBck5zOEtKMktxWG5KR250dTdX?=
 =?utf-8?B?UWEzR3E1cEs0QnN1eXpXamdGMVJBdlU1U1QvRjMwcjFDZndHTEEzcE8vcVYv?=
 =?utf-8?B?cng3VEM3ckxOSXdFaTV2N2JHaDFubFJFeWJYSVlvajJNQzhNV1Rva1FROGNM?=
 =?utf-8?B?WGp3ZjNOc1hRRjRncTlMUElPRXJPbFNScDdSRmFpb0F1UUxLK2pyZExMM1ZR?=
 =?utf-8?B?UGxOS01tZW1pYklUV1h5MEtWOS9vNDlPazhyeE9BaTZnTFkzMWlCYVFHcE53?=
 =?utf-8?B?cjhvY3J3RElha0QzeE1YT25iSm5FTVNjcStobUhGV25LSUxjL0V5TXVzcU1l?=
 =?utf-8?B?RkNTM1NPWk9oMWJoNDJPK1hCczBKa3ZxNCtOU3d4ZkVRb21LbEJJYlVKQVRZ?=
 =?utf-8?B?amowZTBNcExWczFZdnNKanlkNGd1WDBzcTVHOWgvTlBpek13TVhlVFRiVmlG?=
 =?utf-8?B?cWRWbEl1YTd0SEVHRFg2Y0Z1TTlhdWtPVU9jUVJwM3VzLzhtVVZpNkFnNVJj?=
 =?utf-8?B?L3BJV00rN0R5Qk5RQVF1dTFzV3hJSnVsQ0NtdWpiWm1Sa1RzWWtWSnB0RXhm?=
 =?utf-8?B?SmJYRU1TT2luOXM2cXdtTFFFRlIzcnZ4aG1JcUZwYUgwQTZDNEVhNTVhWmM0?=
 =?utf-8?B?NUw4bDRZWWd1RnJmR21mNkN2dmt2M0FIS2tyY1VSTTlrT1ZWZUYvRnZpN3dK?=
 =?utf-8?B?bTB1Y1N2bXVGendISi9zZXZ5OFlLUnQ3QlBhYzlvTTNlem5vZ1hkZUVaTVdM?=
 =?utf-8?B?Rk9rMDkwMTN3N3RNZG9lSmpNY3gvQkx6KzdFRVdKOUNOUHA0SW56M2RvYVVD?=
 =?utf-8?B?eDIzVG5HUU5jRDZIbjlZRHFGTUFadVUyK0VJalhsczZCRzh6L2FtMURTR2ZF?=
 =?utf-8?B?WWQxVTRhSkZ2THdVYXRRLzB6M0c0RXVXYTBadk9Ra2x5OGFSYmlvWEVTSklS?=
 =?utf-8?B?anVabTY1dXJOWXUxazFQUjYrcHFOeWdZQUNPNkNhSTVXQXB4QjRqejc2RlNn?=
 =?utf-8?B?NnJld2RadDB6MWRJL2t0Ylp0ZjZQT011OFBEZjBQa2Jtd1Q1cHZnNXFyUU1C?=
 =?utf-8?B?VS9lNS9IT0RXWnhSYzBIbThHWW1wVWhjQ2pLWnZyV2syQ3NPbzFRdWk2ZEZP?=
 =?utf-8?B?MHhPRTdMQ0xmbjY2alc5WWNudUpxYVlOQk5FaVRjTk1Ub0t6c2tzVzNQR3kz?=
 =?utf-8?B?WEtDNGZ4b1llczlLbUI3aUdmSnBpenNGa0toSWhjd0ZzNVdMbWtxMEtNK0w0?=
 =?utf-8?B?czA3aWFMTytIYWdUWDRUNmRsYTlMeVZIQmlLY0N5Z3d6cFdBckRMRGNvWHZn?=
 =?utf-8?B?Z2hYNmUzU2RSbTV0VEMxTVNKSlRNRUo3cUdHNHZ0RmM5QmNSS0x1TjF3KzlV?=
 =?utf-8?B?THFRelU5MENBbk52dzNrczM4ZFBvRFMyK00xRUhKL1dBMDVwclZ0Nk5QeTdk?=
 =?utf-8?Q?h0CeK3IjxoJ4hc73XoUx+/awb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37dbc0d-d8db-4808-4933-08dd45c3a02f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 09:01:06.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex9Pwb83WrlLZ4uUgdOenTJKnGIhn3jBpLYPju41ShbrrSfs2N5AWxwolcY6WYDf1IYqr4rd1lmDL9pd27ea1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358

<snip>
>>> I was hoping this would get further away from new in/out arguments and
>>> look at centralizing all partition enumeration into one routine.
>> I don't understand?  get partition info is only required if the partition align
>> bytes is not 0.  IOW if the device allows for partitions to be changed.
>> cxl_mem_get_partition_info() is only called IFF that extra query is required.
>> So this does centralize byte information queries into one routine.  It leaves
>> creating partitions to the device driver which moves us toward these being
>> mailbox only calls...
> The crux of the concern for me is less about the role of
> cxl_mem_get_partition_info() and more about the introduction of a new 'struct
> cxl_mem_dev_info' in/out parameter which is similar in function to
> 'struct cxl_dpa_info'. If you can find a way to avoid another level of
> indirection or otherwise consolidate all these steps into a straight
> line routine that does "all the DPA enumeration" things.
>

All this discussion after Dan's patches makes me feel miserable.


I have already used those patches for the Type2 support, and I'm using a 
struct to be used by accel drivers without a mbox for setting up the 
current mds information, required for building up the DPA partitions 
used the new functions. In this case, a struct is needed for sure, 
because there are two alternatives which are more painful than using 
such a struct:

  - one alternative is to allow accel drivers to manipulate internal cxl 
structs what would require, to start with, to export them fully for 
accel drivers. Then those drivers doing non trivial work for something 
the current cxl core is already doing and, IMO, which could be reused 
hidden the complexity.


- Another option, if not such new struct is used, is to pass the 
required data one by one, and although it could be fine by now, I think 
it is not as clean and it does not take into account potential changes 
hardcoded by accel drivers which would require further arguments.


What I have now is quite similar to current pci driver, but using a new 
function for accel drivers (where that new struct is used) instead of 
cxl_dev_state_identify, although some accel drivers will just call that 
function if there exists an mbox. Then cxl_mem_dpa_fetch and 
cxl_dpa_setup will make all the work as they do for the pci driver.


The change is simple and the code now cleaner than the previous versions 
where the DPA mess was still there. So, I'm happy with the DPA mess 
being solved, but ...


... what you seem to suggest now, and I mean both, Ira and Dan, is to 
optimize this which will make life harder for an accel driver. Or 
further helper functions will be needed, or the accel driver will need 
to do a lot of the work now performed by the core. I guess it is not a 
surprise if I speak up against any of these two possibilities.


Maybe it is worth if you have a look at v10 that will be sent later 
today, early in the morning for you, where all this can hopefully be 
seen clearly.



