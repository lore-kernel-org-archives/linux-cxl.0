Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFD2559CBD;
	Wed, 14 Oct 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992108; cv=fail; b=sNbCIxg57dafpioFjdrkLaqOWWqKvXsO+CxzQ+a1Fnfq1z7dshcMm7ScHE6NzBqYaPefUWia6lFX796ipAfJvFE/dw3djiTF/h0ys8FmUljObKRnI7WkELA1xy8QxIeGSt8D6uF6h1dRWTlN7/zhJRloW4pPmDBEJwqq+NWxkfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992108; c=relaxed/simple;
	bh=yR5hcWsZAY2kUTmCzSZFlb2b1V2DFg5V/dg+WQUhdrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nkn+O96eK1LY/WH9LI82drkmaxO6rZCpMC89LS6WNUSOXrJbDkhvDgiUvp9N6j7RlBozMD6QUNNZ+heYgQ5doXBlc/64bhBrUzOPS8Qcl80p/oqYscf1PJwrXtCM8XXUXW/nra5BNhk66GBTm2l8saWYIpYYVCPyXDNogW0B/xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfLssI9N; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfLssI9N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDqkvG2XlzXCnr4cxG7Yvhv7Q0upBUFWRqttj5smmTHZkrhf0bWipzwTDILZpOx/96Z+Wi3ZqBSHXCLm4pHrsZr2Bdm4JI52rSM3xchcSNDKFaQEOdNy5YtSD0cl3EQE3B0Ys0SOS6MVOEy9rVgfhwZJHa8eC5SbRkwfKJDghwrNW/nvdGkcY+jdUSoY0EqCIKj8YhCm4QtK287B9USjO5THLF2fxlli05c4xE/NWkg96oeST4OeWHxsbNyTqOyhdIKgVLX/kel4ucRYLZodiCM6JqqWX9ZmO0QUhfVMjPk1FpRymRXCukwRB7zlYkf+qGMiRONsWgYuQttIBEKdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Oi3sluozbauI8HQCIlmc236Y7BQmhFz6SYGSSSp8aM=;
 b=Hz+/bdHaHJtCGqnFNanrRyUSpIQ7xG2E/vq42y6xOwYjan2zvcpqrfe+oWS2P+anQnPZdN02LHR9YMpIHPsR3z4clnOGVCmL/RFL4eTvG+kJVnZGAFmQkib3N6638+LxDdufY51GSimbeMqhqWrSblTJUa1KCGKbzUQ92MU9JwB1UDfrvgbOVblP4kdjT2FsxPPlEOdeuxynYMT0cAfFiXq2dp+tNRHEKHcb5hbXDMTtRZ+D1RrM/d0627BR0E2jw0xNfLK2s3WKIRMmOqLoYlio8e2HIlRvNVkAEhtbqtMe82QO3mFohQCqSD1ww/+K8MB4pOul4iBDW2bKqQFMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Oi3sluozbauI8HQCIlmc236Y7BQmhFz6SYGSSSp8aM=;
 b=YfLssI9NpB61XBmmsne77np+x3nruH7vxN07aoGG/dDMZ9hG6tNZvAskcipGx5HjYw2sozTCbmAKuWgsVnZVilJXmJ3M37wsdn6IRHpORUfBf0Z6+uCQvHyGDU1DPGcx3lJTUtOj1gRUTDZ3Dqjti514BnSIdoi/it+erYQLpzc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 15:35:00 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 15:35:00 +0000
Message-ID: <1fd14fc6-de0d-4980-ac8b-8138dd5ef17c@amd.com>
Date: Wed, 14 Oct 2026 16:34:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] cxl: Provide explicit RAM region creation for
 Type-2 providers
To: Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com
Cc: kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007090540.43817-1-icheng@nvidia.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20261007090540.43817-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::19) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 056e76de-8395-4a89-8803-08df2a08b59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	R+RsKVgqxiE6xRXFwTxfyRygQiWMEhAJnKF/LydEcdCDrZ9P34gU2EUttr6LW5r9P9uU3nEGwlPmoU8PYF5FW9b3MbaVsSL8tAKK6Zauw78Kpi0XEeDGS7kEjtQDp13vf/Y5lZ6lroz8WeTcMQJxDVXt5stOX+4u8Ar3IBCQb6G0TVPU///G3ROcBa35H/K3gO47rPNT7maehSzSSyUE8wLrjSdRuLveu9CxVrMycYmk7KbCu45N1H1z2p5Z/TT1tIEN6BICH3bJeGfJEcysYsDLrDq9TOrha/YG8xUZkpeJfI1i5dUUHMPM16BgE9NNdjKhTX3TQu6gRljTfwKYJQCV46caEK6G0pT+fjMSro48mKeb/h1m2nkAL/71RXKM1aUBlDt8zpmrvPYNqarwin3jmMsLKGo6Dj0lIxmTAvlMS9qb8FEnVkOIzJQ/lDi7RKUeT+b5M8gSnq6WQf5V8o82bAeUrmAzZjox5/QigBimVmWhrCaywaopMZp6M16RghA89YzZ+KqayhbTwSBg3ZOA2cziNsQ/ymFHYGrKwR1EA946UuXEGX3mznTWIBJJ/7MP4f4lLzAdAJYJbmYIYQANNNuv8v5DBCI+EY93cbYY5qQpoTlo4eyQLxFWoo0UUBJgOUKrUVqVTvPKCZG7//2mzkB7FYiHcbrBnHhAmGE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmI4UUVOWjloVHRjbUZRNFVKS0ZRQ0xVaGl6MFJ3NXVFUU04Skt0cU5CMnlj?=
 =?utf-8?B?aHJqeGt4VXFoMWs4UzU1T3QxQk9RaU9NNUhHbzVXcjMwY0ptQi9WUGNNSG9M?=
 =?utf-8?B?T2pEWXI0RStiOXE1VEE3ejZKNXQ5YkhhZ0FrN3BOUnBkTi9ESGRxOTdaVDdB?=
 =?utf-8?B?c2QvbVhORVpXVG9vRlJLbTdZQUY2WDREUWZwVFVlTEYvVDRYRjVQSlJNc01n?=
 =?utf-8?B?TVhHQzRyNkQ1TEt3b1BBTmJkcnBzVlFlTTZBaXAvRlhtZHlSOGxEMWNzbVJP?=
 =?utf-8?B?MmhiL2lqRFZIWkwrNTRGQ1RzZTZSNlgrZDNaVHU4U1p6QlczTnkvdjJNeEsz?=
 =?utf-8?B?K1puU1VKVmlxL3dWa0kzdXdxdjliRFVNTnBXNHl3NENLY2FWeWYySWwrUEdS?=
 =?utf-8?B?VlE2OE1JcjJPRDJINExkb1ZObkJ5S01RbUpIOUJnSlVBVEpGYzYyaFNkcWps?=
 =?utf-8?B?cFYwc1RaVEQ2SERBWGc5eUpybmIyZUN3cm90NjB6RzZzSnZ6eWpJZnVzYVdt?=
 =?utf-8?B?ZVhudkt0K1I2NHF0SkJSSDJEc2VwQmplam12N2xMbWVzbzZYWGd0alNzVlBV?=
 =?utf-8?B?bDA1V3FMbUNkYVZrUmI2Ni9Tdlp2aEFkVmp6WVU5SmY1eDdISlptSEdXcjBh?=
 =?utf-8?B?TjlWZjZTR3ZlMFdkQzhiVXVJSFpaV0RIRnc5ZC9WMkFhS0p3TDE2YUFRc3p5?=
 =?utf-8?B?Ny9xN1BFQy9mcmp3dEFaOFNBbjhFbExlcEJSSWxKMk51OWl1YTE5VXdpSk5P?=
 =?utf-8?B?VzVUbTBwWWNMYUxwb2ltazBMQnRDQjVXVm4rUmMvTWcwaFprNGJGRCt3eEJE?=
 =?utf-8?B?MGcrUEF5aXlSdzM2TzVPMi84OG1MWTVmem1HUjFGRWVucEN4aFppSS84RGQ0?=
 =?utf-8?B?UGRCZldPMzFTVjhDblF0OEVGeHJIRUJPMk9lMTR5ejByd3VxRlN1UHpLaUxu?=
 =?utf-8?B?L1h2dnFibUoxRUp2b3VCcS9IVFNCMFpzMWlxNkEwdzN4bVZiaks2NVo2am9Z?=
 =?utf-8?B?ZWV5YTZPUHppQWtkYVJ1aXptMmNYOFJaYzAxbVFJbURsWFRjM2xITzRxODM2?=
 =?utf-8?B?MWxlZTBLc3pRR2xrSGVmc29GNjRMZjEwRno2R01hOGs1R3UzcU5GUTdYcmZx?=
 =?utf-8?B?YkF4eFRiZGJGMGV1MitxYkZxOGw0Tm82NUtQZmw3TlpFRTZwYmV1MjdLa1ha?=
 =?utf-8?B?alpmb0pRam01TXliTXVuQWVnYXBkYW5CaFhGOXNCa1dNOVp2b0lYTzQxSFVG?=
 =?utf-8?B?dm9KUCtFbFJpYi9yMzFac21VRFpvYytEVGxnU2ZuRkY0Z25oL2JvV3dCYlpn?=
 =?utf-8?B?NGcxK2xaTjZpVDJ1TUxwclk4MlE2ZVF4ZzJ3cW85R251c1lWZjhtOFNER0NP?=
 =?utf-8?B?QjBTcHovdGpVRzlNeEJ0dGtZaXoxbjJ1eWNINXgxbEFHc2MwL1BsOFBIenVz?=
 =?utf-8?B?OXI2WHQxd29qOGFUR0tJNTNvTTBOTnEzOHUybzFHQnpHZFNPV2NQdUFHQUxm?=
 =?utf-8?B?cUJMYzdkLzNCejR3dnFCY0hJeVhsRzJNTmpvS0FuRXl2elo3N1ErVm1sZFlL?=
 =?utf-8?B?TjVSdTRwRWIzRk5FbHg3WmxwQ1MvMmUzVjgyOW9CYldBQ1BiSFh0eFZkcURs?=
 =?utf-8?B?a0Y0dS9uUGhOQStyUHVEeVVQUGxleVc4c24rMlZKYjYxVTJLVzdSY0hIaWJ3?=
 =?utf-8?B?bXk2ZzJQNjA5d1BpRCtJK2lQL0NtbVVrNkZxV000ZjBFc3JocWNGdXF4T0N1?=
 =?utf-8?B?Sm5GOCtLTElDZVkvb0VRMWpGQkJ5R3dVOHVWazVHUXYvT3E5bmoxSXZNalh0?=
 =?utf-8?B?T1lQTWlWb2JwZnRtZjFRdkVtaU1iZWdPS0JVUjYwRklNS0xnVWtkUjFVQlU1?=
 =?utf-8?B?b3VXVVlSNmxhcDF4MVlvdkpCNjh3bElMcDVkYWY0L0QrV1FjRmtjdVUrYjlx?=
 =?utf-8?B?dXdRanI1SlRWSy94RFFrdlRHKytYOEpnNXlXNHhoR0NNNHBIVjYwNUJ5TVNZ?=
 =?utf-8?B?RGhZcGJXRkFBTE1xYXcrWE5ucndxU2VOZzVvdmwrT3FyRnp3eHVLUWJYZ080?=
 =?utf-8?B?dm1KT2hhc01CTUdwSzBUdXdsdzFSb1gxUU5vWmwwYUhTR0h2YzREU2RvdFkz?=
 =?utf-8?B?V1FXZmx5c240NG9Ua093USt5R1lOVC9FdzQySko1dEdZbFZON0FsNnprNDNQ?=
 =?utf-8?B?a2luMGtFYUFJRFNPNzNtSU9JM2dsSXRMNVI2cEdYRXp2cjhjdnowSkxLd3VO?=
 =?utf-8?B?aHNiYzExMFhtZUlvVTZlOFU1T0F0YmplS1NMUmU2dUUraHhhaFBITzl0Nkhp?=
 =?utf-8?B?Q0Z2Q0k3K000NWVQUFdLcVlJajZMWWxzMEVGeHJMOVA3a3lSUnhJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056e76de-8395-4a89-8803-08df2a08b59a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:35:00.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GfqGaFBJ+1aejMBZTW1cTMFZhJDHKrTaLxukndn5SqXa8zLNkkt1C5HE/Mx8UxmdyLfYRJpdRL5Ayr2hAFVsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649


On 07/10/2026 10:05, Richard Cheng wrote:
> A Type-2 provider uses devm_cxl_probe_mem() to register its memdev
> and obtain an HPA range. This requires an existing committed region,
> so registration fails when firmware has not configured one.
>
> Firmware may provide a suitable CFMWS window without programming a
> region.


Hi Richard,


FWIW, I unsuccessfully  tried to explain this possibility to "BIOS 
people". The fact is, nowadays for AMD and I think for Intel as well, if 
there is no CXL device detected with CXL.mem enabled, the BIOS will 
neither set HDMs  nor there will be a CFMWS.



> Hot-added devices can have the same requirement. A provider
> needs its endpoint topology established before deciding when to
> create a region and how much memory to map.


Another unsuccessfully discussion was to avoid BIOS setting HDMs at 
hotplug time as this could race with host dynamic regions creation.


I'm commenting these two things here for maybe having a community/kernel 
discussion with the goal of defining what BIOSes should do and mostly 
what they should not do if they want to be compatible with kernel 
expectations.


