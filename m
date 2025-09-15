Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0552D46BD;
	Mon, 15 Sep 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925256; cv=fail; b=rg9gTnwlo0CClBcdwNbzsR2ij3yTHcEHBvSVcKZeTTzx2tM5IvCLe8jpFMlnK9W0quIC0y5fcPzJBWBEjeuPBwuHZH3PfulvaYbZJa/r9ZkhgrSWRC6L0nbiD/c1Z7TSfLNqh+3+3E03foozxSJuTnudbTeRZFuXxHPxEVur6ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925256; c=relaxed/simple;
	bh=+9SmHHdmWuq+f8GSMK+VJey0fBkvSb7Ia1Fb0WKyipE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l43o926QufpGWOLls8lXolUliGyE6ZprfxoM44n274SAHkdDBKFVpEw37CnMMGQTDdhx8TflaCmUN0sQ4fPYXjMVGgmtKFdOiZQLwU0G2Wr3xaRKdmJrBMhYfnYGcjFQKiCaWIyEnFZgTwuHKC+EtKQvsob7j2GcycFRNIfWaHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C7wNS+S7; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C7wNS+S7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0P8bOAKsqAIJqeDIbkMB3VlUI7CZix0SCrCmX8vau73s0DrEs63/vImw0YYQ7Fr9kXWKq/XNtnhLEBU4sMji95ZhiFQT9AJPM2ygdX0YvTNnIEn30B9bJDAVXyJjyEWr0auaifgIP3klZTHCd4oQXQsu9hrbebJoHmudHkimKpKJHQT4K9+fMOtGiQHXhPIhzFDLVX/4ioAhHQVGoaMMck4Ei86H4KVVt50FDUmFkp2icLe2C3G0O6fiT0GhoVwZk7Q5Dx2F+hBc2r2kY0P5Rr3B2YU21d0MUi0YilmtMLJqqdtGO//a0xd1yuBbIZQ0xwSHZBf/C/CO19BEexUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfYODv3zIxCscsRT9xNeGA5EXJmM2RsgjgZFUg4xXqc=;
 b=mrK6uVofpSLP3Tv4MOBUSwZHRLXEiwdTJkfisauNR9NYLgCvzxqchq+hy8ZkmZYxX58EXeu+4UT2C+YG8p6GjjoXV8r+6MTX30Exro7wsh6E7UUGNT39s6YvhONf7wnzPxowV0/OWkZu5EUIQP+yopLvjJOk3uS+ce+UmVDodnmr6VJ6Nlrh/MvcGyItxBfV88JN6qNm8A/TVKZl1NRJMXq3oo6F4sDfYsa4UKr+AuaaRbmDZnbKQ2tWSI4Xo5pFhkEHNoGrR6a5U52zBm45yRyeptVfzK/gM+7pANVH9L8R0g5MST+2QZvVCky6yASOWTexiJFCnlfVkjaO+a7WRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfYODv3zIxCscsRT9xNeGA5EXJmM2RsgjgZFUg4xXqc=;
 b=C7wNS+S7DlYYDiat67dJ9ffLNFKSTvnyDQLqMv4K3LWpEa66kPt1A2b6RM9WTKGBlRA30qPqDfq1TycTnqpXB4kPb17FtJ5ZTAghQC1FMP+fB4JFNb6HbeRyMV0psSL/AyzEFMN8F7fh8EKtbOsVIyogORqMSaELEO+82NS2MF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 08:34:09 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 08:34:08 +0000
Date: Mon, 15 Sep 2025 10:34:03 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aMfPe6HY3Xb7Yl6l@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
 <9982ec28-b3d8-44d2-be32-bab4b09a00d7@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9982ec28-b3d8-44d2-be32-bab4b09a00d7@intel.com>
X-ClientProxiedBy: FR4P281CA0355.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2d21d5-996c-4e36-be0b-08ddf432a377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjM0cUhwdjZpdFJmamlRNmt5ZEpsaFMvbjhNNmRJVXp0V2psSDQzVnltS25Y?=
 =?utf-8?B?OWxONGt5cDVob2xwazJDVHR6dFUvZTI4bGIvWWd1d3dkN3ZMclFzODRFQity?=
 =?utf-8?B?MW1oRFF2ZiszUjBpNitFeExPSmpDbjdGRHNlN0pXa2lvWWRQYVRyaHN0ZWUx?=
 =?utf-8?B?YUViVC9CQnNLWllpV1RjU0VHbzYzMFlqcjY1VEROdHZoNDJRL2RkWnhXR1U1?=
 =?utf-8?B?Nld3THpjNGZ2YVJDbWpEVXlFc0NaSGdpN0Q2dk9rRCtOMXpoY2RYTjlGZUw0?=
 =?utf-8?B?cXNuSDBGQkh5SFpCakFyV0VNSUtSYUxFd21VT2g1dEVLaG1YUHJ5U05Ic3hq?=
 =?utf-8?B?OFNEbC9rZmo0M1pqMXFhNjBrNk93Rmt3Z0pCUDZZN3lmcVpoNjhuQmFaTmIr?=
 =?utf-8?B?Z1BWdVJnUXFsQmRRV2tTald6cm43VUdVb1BmUUpqM0JhQXNqQ0ZrclhucVF6?=
 =?utf-8?B?VFhmTUpDWG52a0NKdHQ0dTJCVG0wdmZOMU5wVmhIVnZOK1k0UTZieWd5U0hT?=
 =?utf-8?B?eFNxclRzY2F4VVBTWTN0Z1VhbUtoUWIxWWxkanFBL2t2QjRQekpVaGtoWmFM?=
 =?utf-8?B?Vkc3U3daUU9BdjdlYytJTEN4TUhaN0hnMEZnc1pTOVc2SzE1WVFaZGJna1I1?=
 =?utf-8?B?Yk5vSVhHdU5pNWl5djJ0N1pMd3E4bzJ5OVc0eTVaaHdpeWdtd3B1SXN3ZTVN?=
 =?utf-8?B?WlhTeC9XREN4YWtVdnhHRmIvdGlRYUdJM05Hc2JpQkNpVWF2elZzNEpWU25G?=
 =?utf-8?B?ZDVaQldRMjVBYmR6cTZ3by83c0lYMEhkbE5Cbm1zamg1ODFrVExmNnBXQnFt?=
 =?utf-8?B?Q1lOL3owZVRQdFJzbWZsZ0RjT05YWnhTNnZ0dE1hQTRRRDNtdGVlWXZIYy9j?=
 =?utf-8?B?MG92b1NXQ3N1MElRL3pBZkR2bG94Qk8vSDhRcGk5ZHh4cjJkck9aWU5pOUQ0?=
 =?utf-8?B?ckJPTkVtanlROUMweWk2QzZ4RHFKWFZIWGZoMWFxRGdnUy8zd0RUSDBxbUtk?=
 =?utf-8?B?MWZBSGo5VVhsVkR5cG5naGQ1R1lNMWh5U2xvZzNWQ01rTjl2OW5LTGJJRktX?=
 =?utf-8?B?RTJiNVpVbHprUmQwRnVYNnJRbEZvbDVuenZqR29ER0g4YU9MNnoxcVEyUDJ3?=
 =?utf-8?B?V2gyQWtpRmFBdHpvVEVvUWdGZ0N4dzI3VG1wdXUyM0xzWklKMnZTaHdiWms4?=
 =?utf-8?B?b1h4WWpZL05rckFWL2NZTUJNUngrbElSbk9EOXFjanVDWGIvb2svYWZmdkxG?=
 =?utf-8?B?TEdscFcwRk50eGQ0dS9DZUtvNVVBMGFPUDNUOE9IQlRqVjM3dGZ1b1ZjNDU4?=
 =?utf-8?B?NGJUQzZVVDNQeitIc1N6SUxkTHFPTjlHcVRoQWo1S0JXaVBLMmhFTFhrVE5K?=
 =?utf-8?B?UVAyUG45dGQyNkNFMWdFRGZpd1RTU3lRU1YwZU4rM1Z3bVMyTVhzRUJLQVlE?=
 =?utf-8?B?dnpsMlEzZkNRT3BXaFBpZXJBZFpBTlkxeFBvMkduLyt2UVlnQ2lxelFtTHZm?=
 =?utf-8?B?c1djVjh2VGxVcUM3WEQ4VzhKUnRXRXUwaHFweEQxVEtKZi9HSHlmR0hraSsy?=
 =?utf-8?B?VVdtalBVSU9XYVArc2FBb1Rlc3BQR3pPbGNnU0VTOW5xTWs1VksrMjdXV24z?=
 =?utf-8?B?RmNRc3NMVkpMcGE4bzhIdnVhK3RlSFVaSGE3eUlrelkvMUZ1N2VIMkFvbGgv?=
 =?utf-8?B?bjdJWDY2VnJpNlp0ZDgxQnlnbTE5VEJjNDM1cnN1Sm43L1lxK2hnYXoxNlZJ?=
 =?utf-8?B?aE9Ua0pRbWd4ekIvTkFoajduOVNRVGFBYk9VSVQyam1NRFpCb3NCVkJpMlBZ?=
 =?utf-8?B?ZVpzciswNGtFZGZVZU16Yks0UTFMNFVVU1p2UElZNjhCRjBBSWhFa1hxZ3Zx?=
 =?utf-8?B?bXdPem1RaXlkS2cwWHNKS3gyWXRxZXdNVHkrWVc1K0VocVphY2E1WE9WeDYx?=
 =?utf-8?Q?OSv3WzKHBJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGpqSlplYjR0eldDVFBzTUxFRjB2RnhYS1EycTNQZUVKUkxmUlBoVVVPc0ZD?=
 =?utf-8?B?elNaR01vOUVuQTU1WmhJR1dPY2lSQWtZSW9XcEZXb3Y3Q3B0UXNQZnZRYkR4?=
 =?utf-8?B?eUN1aXBCcTFIMDViWlUwVnlRM0RZVTBDbmVDSXFXTFZpWG1EZmtuSFRCeU1s?=
 =?utf-8?B?ekc4bXdnWGZaaXJEUzB1SU1SUzRpMFhWZ1dCVzlEQS9IS2Z3bURRWFpoaENS?=
 =?utf-8?B?N3hEYW5HbzUzOEwzNFJmdEdSSDVnT010VzBEMHpCMXlYME5KeGNaT2xieVNC?=
 =?utf-8?B?NTF6QjBEL0M1cnB6eWVCQ0xCN3VNR3ZpbXZrUFJRV3RuS2dPaTJENmdTR2Jx?=
 =?utf-8?B?alNwWCt1cEE1bWI0TGN4WTQ4aGtVbk90dkNGME1KZU9FeWpZUnZ2REF1TlBu?=
 =?utf-8?B?V2RWek1uc0ZWWjZvTVBjSXVRV1huaGYvaWExNVNDWWRhQi9qWjNPbWZiTnVV?=
 =?utf-8?B?bHJsdHd4THgwa3FLS2ZpdllhdkFqb2NCK05INVJOWDBUZWhBcUoyK2I4V2ZG?=
 =?utf-8?B?MDJNNFlHcDlIRlpoaVA0YXBsRHFDN042YjNDc2xmYk9RZW1RcXZxWCtFODNX?=
 =?utf-8?B?c3JkdHNTRDRNVHZVcnhadGpzTGoxaGVVOUZva3lIaVN1U1NpakFGaUlYZXdq?=
 =?utf-8?B?djIvekZ5MXJWRHZ2eWxyQkhqamNsTmR5SmJqa1ZwYlFQa1NmamhXRmdJcWhX?=
 =?utf-8?B?dU9sbkt2RnJZeXFUcU56cW8wZzJPRytPRG0vZHRtSVVXQUluMyttc3liZHRR?=
 =?utf-8?B?UVpZenlJWDhrZHNGRVd4UWtId1EvT3c3ZjdYSmpFTTFwTEg4ZmNVZmozRDJm?=
 =?utf-8?B?dXI5eDRrNTdwRUIzR0VBelpIdnptcTJiWUJwam4wRmY1R0xmL2VZdGh2ajNk?=
 =?utf-8?B?OUtTaTBFWEUxZXhKcmpHMXJhbHJUKzFKWm94bktHNHF6UzE5bkt1Q3VINStZ?=
 =?utf-8?B?YTlnNFNYZkV4R2RMUi93dEZ2Y2x5MW5EeHoveVhuU2ltMTlld0xtWHdhSUh4?=
 =?utf-8?B?WjNSdkVvYlllVG5TN3ozdkJWWHVTUnV0NFpTYnJFY2ROekp5MlNiaDMwUHF1?=
 =?utf-8?B?cy9uY2gzOWFtN3UyVFk0VnZ1M1FUbWR6b2pwalFJRnQ0T2drMHJIWHRqb0Fk?=
 =?utf-8?B?bGttOEs4ei9nZWFuRFNoSGpJUEdPc3ltcGNOSHJ3QkVHZzlGUEd3R1ZPcGF0?=
 =?utf-8?B?b21iY3FPbDFsSnFtRlFTbTd3VjNmZUNBbmFlbGlWQ2M2eGxsLyt6MEkwSXlO?=
 =?utf-8?B?a0d1T2xtc2kvVEpDNjlBdlN0cWVxMGQ3dS9vUWMxQTFkdmVXdVFETnNGSUdB?=
 =?utf-8?B?MHpMVlBCQlJZQWdSRzJCeFB5dERScGhHRTJVSU5vQlRwRUtaU2xUREV2SmRH?=
 =?utf-8?B?ZnFTMEFrOU9ZUE9uRG1ONGN5QVJUQnFmWStCM3VMbzRRWk1LeU11dCt6WXhE?=
 =?utf-8?B?RFJwckkxaXRnSzFLRm85V09Ub3RjbFRKSVlwbG9VSThuT2xtS1I5Q1BVMGF2?=
 =?utf-8?B?d1NPU2dFNFNpWC83cUovaHBJTzBDYjh0NS9FTklTZHJuM01FVTY5bnQ1b0Vn?=
 =?utf-8?B?NmJneHpybEZ3OHJ1bUdIR1hKSU9xYXppQ0lMOU9CWXdDQ1UxR2NZRlQyQkhQ?=
 =?utf-8?B?WEVrZlF1SitzNXVybVVJdHI1Uld4c3FzQ3orUGI5dEpHNXpFQVE2Sm5oREtG?=
 =?utf-8?B?RUViMkFsYXMvWVM3Wm8zTjZMUE1JRFJDamtmOHhJNWhJNllIUTZNWnNmUXBN?=
 =?utf-8?B?WTcvRzdxS1R3VDFUdXFodGd3VVQwZzBzd05aVStxV0g2eEVrdGJIallBWWxs?=
 =?utf-8?B?ZkdUZDB4WW5zeWVJc0kySWlFWWpncC9MeERmZnlKL28wSzVBRWZTNkJ2WlVU?=
 =?utf-8?B?YVgxV0k4QVZEQkR5dkt5aEt3N1N5c3daa0tXVUVscXR5VVFIZWY0VlRvT1JO?=
 =?utf-8?B?RWcrSjRHTDl6dEdXUDNYZ0l3aXhHSSttL1lYdlI4NUNDK0IwTkY5R0xPcGFk?=
 =?utf-8?B?NnNyTm0vclJ3RmpRRkJscndSazFFMWRQSHhlRHIwVk85OVFUVGh1QzZCSFhT?=
 =?utf-8?B?elFyZHZva1FXb0lBWElKR09xNDRPRnZNa05OTGpWZnNKVzR1OEhFeTBEV0Yr?=
 =?utf-8?Q?SfvEWD5j/SX+xnoUuG/jYRg8z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2d21d5-996c-4e36-be0b-08ddf432a377
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:34:08.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqzbsxFnOJ6P0u80egaW6dRZVutB43Ht6cLpe6hExUGDfb8MleAJEKpzHsBlEcZiFVlVTseifdJeDFdwmqAxag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238

On 12.09.25 16:46:23, Dave Jiang wrote:
> 
> 
> On 9/12/25 7:45 AM, Robert Richter wrote:
> > Add AMD Zen5 support for address translation.
> > 
> > Zen5 systems may be configured to use 'Normalized addresses'. Then,
> > CXL endpoints use their own physical address space and are programmed
> > passthrough (DPA == HPA), the number of interleaving ways for the
> > endpoint is set to one. The Host Physical Addresses (HPAs) need to be
> > translated from the endpoint to its CXL host bridge. The HPA of a CXL
> > host bridge is equivalent to the System Physical Address (SPA).
> > 
> > ACPI Platform Runtime Mechanism (PRM) is used to translate the CXL
> > Device Physical Address (DPA) to its System Physical Address. This is
> > documented in:
> > 
> >  AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
> >  ACPI v6.5 Porting Guide, Publication # 58088
> >  https://www.amd.com/en/search/documentation/hub.html
> > 
> > To implement AMD Zen5 address translation the following steps are
> > needed:
> > 
> > AMD Zen5 systems support the ACPI PRM CXL Address Translation firmware
> > call (Address Translation - CXL DPA to System Physical Address, see
> > ACPI v6.5 Porting Guide above) when address translation is enabled.
> > The existence of the callback can be identified using a specific GUID
> > as documented. The initialization code checks firmware and kernel
> > support of ACPI PRM.
> > 
> > Introduce a new file core/atl.c to handle ACPI PRM specific address
> > translation code. Naming is loosely related to the kernel's AMD
> > Address Translation Library (CONFIG_AMD_ATL) but implementation does
> > not dependent on it, nor it is vendor specific. Use Kbuild and Kconfig
> > options respectively to enable the code depending on architecture and
> > platform options.
> > 
> > Implement an ACPI PRM firmware call for CXL address translation in the
> > new function cxl_prm_to_hpa(). This includes sanity checks. Enable the
> > callback for applicable CXL host bridges using the new cxl_atl_init()
> > function.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> I'm still trying to digest the series. Couple things below.

Thank you for review, I appreciate that.

>  
> > ---
> >  drivers/cxl/Kconfig       |   4 ++
> >  drivers/cxl/core/Makefile |   1 +
> >  drivers/cxl/core/atl.c    | 138 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/core.h   |   1 +
> >  drivers/cxl/core/port.c   |   8 +++
> >  5 files changed, 152 insertions(+)
> >  create mode 100644 drivers/cxl/core/atl.c
> > 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 48b7314afdb8..31f9c96ef908 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -233,4 +233,8 @@ config CXL_MCE
> >  	def_bool y
> >  	depends on X86_MCE && MEMORY_FAILURE
> >  
> > +config CXL_ATL
> > +       def_bool y
> > +       depends on ACPI_PRMT
> > +
> >  endif
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 5ad8fef210b5..11fe272a6e29 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -20,3 +20,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
> >  cxl_core-$(CONFIG_CXL_MCE) += mce.o
> >  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
> >  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> > +cxl_core-$(CONFIG_CXL_ATL) += atl.o
> > diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> > new file mode 100644
> > index 000000000000..5fc21eddaade
> > --- /dev/null
> > +++ b/drivers/cxl/core/atl.c
> > @@ -0,0 +1,138 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> > + */
> > +
> > +#include <linux/prmt.h>
> > +#include <linux/pci.h>
> > +
> > +#include <cxlmem.h>
> > +#include "core.h"
> > +
> > +static bool check_prm_address_translation(struct cxl_port *port)
> > +{
> > +	/* Applies to CXL host bridges only */
> > +	return !is_cxl_root(port) && port->host_bridge &&
> > +	       is_cxl_root(to_cxl_port(port->dev.parent));
> > +}
> > +
> > +/*
> > + * PRM Address Translation - CXL DPA to System Physical Address
> > + *
> > + * Reference:
> > + *
> > + * AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
> > + * ACPI v6.5 Porting Guide, Publication # 58088
> > + */
> > +
> > +static const guid_t prm_cxl_dpa_spa_guid =
> > +	GUID_INIT(0xee41b397, 0x25d4, 0x452c, 0xad, 0x54, 0x48, 0xc6, 0xe3,
> > +		  0x48, 0x0b, 0x94);
> > +
> > +struct prm_cxl_dpa_spa_data {
> > +	u64 dpa;
> > +	u8 reserved;
> > +	u8 devfn;
> > +	u8 bus;
> > +	u8 segment;
> > +	void *out;
> > +} __packed;
> > +
> > +static u64 prm_cxl_dpa_spa(struct pci_dev *pci_dev, u64 dpa)
> > +{
> > +	struct prm_cxl_dpa_spa_data data;
> > +	u64 spa;
> > +	int rc;
> > +
> > +	data = (struct prm_cxl_dpa_spa_data) {
> > +		.dpa     = dpa,
> > +		.devfn   = pci_dev->devfn,
> > +		.bus     = pci_dev->bus->number,
> > +		.segment = pci_domain_nr(pci_dev->bus),
> > +		.out     = &spa,
> > +	};
> > +
> > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > +	if (rc) {
> > +		pci_dbg(pci_dev, "failed to get SPA for %#llx: %d\n", dpa, rc);
> > +		return ULLONG_MAX;
> > +	}
> > +
> > +	pci_dbg(pci_dev, "PRM address translation: DPA -> SPA: %#llx -> %#llx\n", dpa, spa);
> > +
> > +	return spa;
> > +}
> > +
> > +static u64 cxl_prm_to_hpa(struct cxl_decoder *cxld, u64 hpa)
> > +{
> > +	struct cxl_memdev *cxlmd;
> > +	struct pci_dev *pci_dev;
> > +	struct cxl_port *port;
> > +	struct cxl_endpoint_decoder *cxled;
> > +
> > +	/* Only translate from endpoint to its parent port. */
> > +	if (!is_endpoint_decoder(&cxld->dev))
> > +		return hpa;
> > +
> > +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> > +
> > +	/*
> > +	 * Nothing to do if base is non-zero and Normalized Addressing
> > +	 * is disabled.
> > +	 */
> 
> Not sure if this comment matches the code below

Non-zero is wrong, I meant it must be zero-based (means DPA == HPA).
Otherwise, if not zero-based, Normalized Addressing is disabled and
translation is not needed.

> > +	if (cxld->hpa_range.start != cxled->dpa_res->start)
> > +		return hpa;
> > +
> > +	/*
> > +	 * Endpoints are programmed passthrough in Normalized
> > +	 * Addressing mode.
> > +	 */
> Not sure if the comment here matches the conditional check.  

Passthrough implies interleaving is disabled and thus ways must be 1,
will update comment.

> > +	if (cxld->interleave_ways != 1) {
> > +		dev_dbg(&cxld->dev, "unexpected interleaving config: ways: %d granularity: %d\n",
> > +			cxld->interleave_ways, cxld->interleave_granularity);
> > +		return ULLONG_MAX;
> > +	}
> > +
> > +	if (hpa < cxld->hpa_range.start || hpa > cxld->hpa_range.end) {
> > +		dev_dbg(&cxld->dev, "hpa addr %#llx out of range %#llx-%#llx\n",
> 
> Suggest use %pr for range printing to avoid 0-day complaints on 32bit compilers.

Ok.

> 
> > +			hpa, cxld->hpa_range.start, cxld->hpa_range.end);
> > +		return ULLONG_MAX;
> > +	}
> > +
> > +	port = to_cxl_port(cxld->dev.parent);
> > +	cxlmd = port ? to_cxl_memdev(port->uport_dev) : NULL;
> > +	if (!port || !dev_is_pci(cxlmd->dev.parent)) {
> > +		dev_dbg(&cxld->dev, "No endpoint found: %s, range %#llx-%#llx\n",
> > +			dev_name(cxld->dev.parent), cxld->hpa_range.start,
> > +			cxld->hpa_range.end);
> > +		return ULLONG_MAX;
> > +	}
> > +	pci_dev = to_pci_dev(cxlmd->dev.parent);
> > +
> > +	return prm_cxl_dpa_spa(pci_dev, hpa);
> > +}
> > +
> > +static void cxl_prm_init(struct cxl_port *port)
> > +{
> > +	u64 spa;
> > +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> > +	int rc;
> > +
> > +	if (!check_prm_address_translation(port))
> > +		return;
> > +
> > +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> > +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> > +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> > +		return;
> > +
> > +	port->to_hpa = cxl_prm_to_hpa;
> > +
> > +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> > +		dev_name(&port->dev));
> > +}
> > +
> > +void cxl_atl_init(struct cxl_port *port)
> > +{
> > +	cxl_prm_init(port);
> > +}
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index eac8cc1bdaa0..624e438d052a 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -150,6 +150,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> >  int cxl_ras_init(void);
> >  void cxl_ras_exit(void);
> >  int cxl_gpf_port_setup(struct cxl_dport *dport);
> > +void cxl_atl_init(struct cxl_port *port);
> >  
> >  #ifdef CONFIG_CXL_FEATURES
> >  struct cxl_feat_entry *
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 8f36ff413f5d..8007e002888e 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -831,6 +831,12 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> >  			    &cxl_einj_inject_fops);
> >  }
> >  
> > +static void setup_address_translation(struct cxl_port *port)
> > +{
> > +	if (IS_ENABLED(CONFIG_CXL_ATL))
> > +		cxl_atl_init(port);
> > +}
> > +
> >  static int cxl_port_add(struct cxl_port *port,
> >  			resource_size_t component_reg_phys,
> >  			struct cxl_dport *parent_dport)
> > @@ -868,6 +874,8 @@ static int cxl_port_add(struct cxl_port *port,
> >  			return rc;
> >  	}
> >  
> > +	setup_address_translation(port);
> 

> Given that the address translation callback only is needed for the
> host bridge, should this be called from acpi_probe() when the host
> bridge is being setup rather than going through every port add and
> checking if the port is a host bridge?

Will check if that is feasible.

Thanks,

-Robert

> DJ
> 
> > +
> >  	rc = device_add(dev);
> >  	if (rc)
> >  		return rc;
> 
