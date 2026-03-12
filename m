Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0D3FE356;
	Thu, 12 Mar 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337052; cv=fail; b=K5ROQJvdkfb5teQI36fCJJmrpvgzozzYcoujR2BNpJ6o91an6WI0hP3Im+otW4TRtQCeh41hCMx5P46FhvgSK4AR61F9JJ/Qx2NiuF1+GimtjWS5ohbwTGQCHV+vK5IQ50UASB8NkA7VE0Yiab/8wLuSaT6wiOLfdlDBRanKjOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337052; c=relaxed/simple;
	bh=WCjtdnUzklrpYlSK6TD9ecLFOVQMoYKjYBWfXDma5gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C3zQT5s531ZU/KPUtN9wVQzg9mWLKaSWxhkQPTV0bj5+3VtxZlSoE4tsG+WKeQ21oWrD+dBZO9IsuslBzsEPNcy8zoXyEvDS1VZqCWITTz6U5KUYzl+uTQSCUkjQyRLSIqp7DNh6RONwXjJ1Ay0NjnxY9fanGTU/MvtcMj4Tbq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Fer85fR; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Fer85fR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey4fR1NcaDPnUdvblkoZw5idCaYDO7+ng+4Nt2/kHUGLYXWzWtfE3l62smibh/gPmrbQb9SLn4VrEj9ILd0VW6R0PWeEWHw4I8WEgpInq68x7k/lNBDhYdwBlM3/WWETOlHu5B3ctGUgODx621hMvMYC6ij5VK6yqE2rGdT1uUP7rrre28mqNqCvgJd4TMwePVhrfg/CHHk+3/qc+za46+9emeYie55lSpLdgpOdoUW7B7UEgtxQgH1A9XSZWAMpqJK0m/DJnYOLRsRFsBzJDM1jbZkAoKye/TYcRWxdh8GlhRr5bSfuRrdYXYITOjSPwc2plAupNpELYF/N+ECKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wgZB4Wnblfoa4lKBjSJJE2CghMzYTWq1L3QgmYL0mA=;
 b=s+2U+V6XfYnIE5UgmN/qAW979+9qfNguQF3UUkat1/mKnzlW9+cIdxg8wfNKQTOFriz1JOBu2ebg+XZpoDNuicXZpR74gD7p4oJDMsWcdSqIO0qRl2SDA1JVbfXvt7jWPRupPL8NjXCyH6wsS2/1mg9R0n4kZB1/0mexO301kgtGnJl8WvGxUnfA2aLWlPq2Q0qT83Ps3dZ+m+uSFhqgZXc0XL7G04feDeXa/2wVVEchM51tpkwhBIQpjFsW2OibyPa9r+Aku+mHej7zJFY+wYyiRYb5tw2hCQ9hxh5l0zjMbCPa88+djnw02Sr8TnDr6cobdfqz/rBjbEeV0f4Nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wgZB4Wnblfoa4lKBjSJJE2CghMzYTWq1L3QgmYL0mA=;
 b=4Fer85fRJ7i3z0LmEI4TSBYW9vlPWLZf4jiFywSKIIYP7YRD2PXTKsJLl258eutIToFg92+PlhMQx3QInsdPDJkMkvAqdeNwlGloqNNYAUH99Ol22u/isaUecg76VkRPPEKog7WenoNLTny/yyW8v9Dqvk5Qyl1qtWkVlWKdc1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 17:37:27 +0000
Received: from LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6]) by LV8PR12MB9714.namprd12.prod.outlook.com
 ([fe80::8c9f:3a5b:974b:99c6%6]) with mapi id 15.20.9723.006; Thu, 12 Mar 2026
 17:37:27 +0000
Message-ID: <dd8e4ae0-94db-4c2e-ae92-6e01e07c626a@amd.com>
Date: Thu, 12 Mar 2026 10:37:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/hdm: Avoid DVSEC fallback after region teardown
To: Dan Williams <dan.j.williams@intel.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Terry Bowman <terry.bowman@amd.com>,
 Robert Richter <rrichter@amd.com>,
 Benjamin Cheatham <benjamin.cheatham@amd.com>
References: <20260212223800.23624-1-Smita.KoralahalliChannabasappa@amd.com>
 <69b0dff5b6043_2132100cd@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
In-Reply-To: <69b0dff5b6043_2132100cd@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::26) To LV8PR12MB9714.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9714:EE_|CY5PR12MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 87172b61-f151-47cb-8f38-08de805e0754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J/RH4/Tr26qK7E4n8XNPy7duzbtV17YlnrbF4y1105u9Oei3fdksFPJAYCpt3rR/wtNsUK3WqTKZc0ZqUc6UZ/XGUm/TtwOMW6LdgfMAqQMGChkla8t/wa9qVWM26he6gRTlNoW3zeO/zlh6OKMbrHdYOIOZEmyiXv/nnBDbwCTmZr3csOUqmK8H9sXYVLawQnG7HAYVs22ehkt5VpMonGbLAhg/vUEs7gbKyogMD5aaRju5a/xtX8DVx5uT27Cme9Hfe+YF4g7OgHrmG+XuMg6lGoJRgDEdhAKLZAOXjVNg6S+IDyM3n5RfqIXdD3Enm6sfpahs7hzF5mcOV0ep1dM2yXhNdPD1Ecg3I1Yh6eFKsgGtCPM5d0tZaFCyQlpTfIP5W+ZDEEuzL83OuWDpt75PKgVnwFBJFADs4ST3WE2Q9MZNfO73yibMSu+fblesgajVhN84t5pTtDLaSW9BWpw4UPn+PEJ/uxbfxK3fYrll+dYx3KGBlkeibjr+3+ZflojPkwk+lugaP5hdanYTk7sZnxvKPqtMSPR88Yg5ElxyoepeyEwRf7xDKXRCCwWLt5HajZ4FyFYLBPmVWtCA9WbOp6I1waY4PEQ1wfkJ1PUBfhEkk+txdXkhqFLL+XEuXtEAK7b1yj6H/0RCKjQmNZO09ezmrZ0si6/R3XetrxQKRXcxLXYuct3BFvxFsqgDHQI7JgxnR3nzibr9kvucDAAowxHor0hkbunmBDE3o6Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9714.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzBhZ0NOR29zeTdrSFM3MlFEcll4RDJBTk1JUHB2MVAybVhWbVZBRm9XZnhS?=
 =?utf-8?B?SXY3VnpuZ1pjWVFtcjk4UUwvcG9HUmlhczFYNHJ0dldJUmdDT2p1a3ZvSTRG?=
 =?utf-8?B?Rm80M3hSbjZ4c3c4QjZDaEJZOGVwWk9VK2tULytCS0FSUEtybG5pOHlzSWJP?=
 =?utf-8?B?aDhCYlo4bDM2RTlTV08yMzJ0a0wwWXlITUNXa1EvQkJLblBTYWpCOGFqN1Va?=
 =?utf-8?B?RStjK29rNTM5TWpMVGZOdVBFQ2pIMWtybUZRZXBDZm5tYmVCcmJnUlN1Nllv?=
 =?utf-8?B?MlFlb0N1Zm9LaS9Ma3FUMlZXZHFIekFTMDlFVzdQc1c2ZU1MWnMraWExWkMx?=
 =?utf-8?B?Sk50VFNMaWxSRzJ5T3dqQUJSRmRCRndJdTlPS0grYXVHSjVxaDBrU3h2TkFC?=
 =?utf-8?B?WC9KNUg3YnVjYU1GTkVRcjFwNFBFQktQQ0oxeThVYUhHQVBiaVdqTGdzMktZ?=
 =?utf-8?B?dUYzRlk2T3JIWHBvcDhKR0p3TDZDRzliS1pxTWFCaUw5RHE3bGhkSzNvSktS?=
 =?utf-8?B?VUFRMVNwSmlXTFpLZmJycGZRZm9HM243TFBBenRkVit6YzY2bEJISm5Mdlcy?=
 =?utf-8?B?VkwxOHlGSDloRmtROGZqRkVIL3VWSG05VXdlY29SNGEyL2pVWHV3QjNtTmw4?=
 =?utf-8?B?VXRWUEtpMjNNbkdYV1p4R3pvWmdrRGxiNS9FRGxSSXlaaVc1enFoblR0UU45?=
 =?utf-8?B?YWF1djN4Q3g5MmFjM3hrZ2tjOXVqVUJpaTRDZ2dYd0VyME1QWGM0cXRyNFV5?=
 =?utf-8?B?ZjB4emFjbG5MYVBWZkQwczZrcHlIL21OWTZMdnNxZUNremo2QlV2eGQreG9k?=
 =?utf-8?B?WHJ1NElFbFIrWS9HbGNkWkI3K05PZlljSE5wVFFHOFBRSUNNbnVRdVhkMTdm?=
 =?utf-8?B?SU1oNlJwamcrSCtiRlRpcGxoZFozaG8vc2NORFhLR2pnWm9SK1k2ZklxOE9m?=
 =?utf-8?B?UHlxbllaVGtXZGRnSkJJKzZQcXJoVWJYTHNEak05eFR1eVhIbld3emJXeUtz?=
 =?utf-8?B?a1RZcUZNeGNEU3MwT2x1Ym5ET3BXZzgzRG1adkZzZjJEWll4ODF0b0xGbkRM?=
 =?utf-8?B?SXhOM2dCcDZkSUlZVTUrMmF3RTZKeHNEMzZIK1l6UjQ3d0tjR3JhSERaZkxL?=
 =?utf-8?B?eG0xZE9SeGdLeEdlTmhpdFdtcHVkdEtNbjkvV3h5R29Hbzk0dExXeWRJL0Fo?=
 =?utf-8?B?U2MzNmFXdXVzMnYxdnV1SGs2Z1ROT0dlYmFBb2NmRlBQcXNKTHFQcTV0MnRj?=
 =?utf-8?B?VTZZeUh6MzRzUHRxcjdXNkI4d3NqdXhGelgyKzI3VWhHMGlSc1dOajNRZG85?=
 =?utf-8?B?dmZCQWNpUWZlTFlmb2NBUVJja0owMVhrbWRhMjdvc2dsait5K1Erem43TnZE?=
 =?utf-8?B?Y1o5NHNzQUlRUXlnM0FSVFJnZGlKZHZYWnhCcXdmbklTQ1Rwa0JERHVsUUll?=
 =?utf-8?B?WUV2M1JjemZYTXBJblhQRWowbHgwcFI5a1pFR2pESU14Ti9KV2dZemJRVzB2?=
 =?utf-8?B?Ylh4YkdKdEs3YWIzM1ZldUNUM1FrNFlFdXVjc2lCTnVpdWxFaUxWcE9qMzND?=
 =?utf-8?B?emE4bFRaeTZ6cFI5STBwdnZEZzJDa3FNazJESE5rbVJ5cFVTelJjMXRWS3cv?=
 =?utf-8?B?Tm5CNEx5UjladzdKWGk0RWtyUC9lQVlqdTNMd0VBWFRrTUxZd3FISFFnTzN0?=
 =?utf-8?B?OWg0Vk92RmI1ejlCTE9HNy9YY0xVKzJNUnNpR1FUUUlTUnlSV0Z5L0xabUdT?=
 =?utf-8?B?V2lVUDR3eU1SdmErZHBiNmxxSmtMUHhycUw1L0NsLzFybmt2bVM2d21MaHpR?=
 =?utf-8?B?U2NicnFQMUJZRXZFQ08yOWRwQ2FsTndJamRRSTBLTHBPUVJFVk1jWWpybU5j?=
 =?utf-8?B?citjTEFuZlppbUlMam94cHRuNEdVazVBRWd5bmJmU3VQQ0dCczNLZWwvYlVE?=
 =?utf-8?B?Z2NnUXNIeEFzMGp0OUpXWnozNGt5clhDdmVZeWxDNXZOWjI5cTdaSHc3WEE1?=
 =?utf-8?B?REdPTEhKeFNta0JNY2xJQTlpdjRUdCtNVVB2bWlDbTI3Rk5KSlJMbG0yT3Vv?=
 =?utf-8?B?WlV0TjVCNDVocnVCTnMveGM3SzNqNStNYmt4cHh5OGN4WlkyNDEwbmd6c0pW?=
 =?utf-8?B?T29LaDhQVEZsVWpxcW9WUTBqdFNZbU1ibDVXRVgwaHhyVy9DUzhVZGNPcklt?=
 =?utf-8?B?UDNoV09GYmx0MmIwZFpnWHZiMG1Uc2RJVE9XY2FRd2RTUTJVTXZpZmdBU3FV?=
 =?utf-8?B?S0xkZndxczBZcjhvSFIxWXc4S2tidWxGbEdVYmxwb0pCVi9HWmNTTjRRN1ZN?=
 =?utf-8?B?czJXSjhPTXlKRnNtMUd5VzBmUjdUa2I0Y0JqZXV4a2FnamJVaFFiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87172b61-f151-47cb-8f38-08de805e0754
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9714.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 17:37:27.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucdCVTO/9M52GxEr7CXwD0UBSEFi39TAH9bJzi8YiFN7I6P5UPqdXxVZBU5YIRqB8ypV1SpTP7sdej3EYEoWVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598

Hi Dan,

On 3/10/2026 8:22 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> After destroy-region, cxl_region_decode_reset() clears the HDM decoder
>> registers (base/size/commit). If the memdev is subsequently bounced
>> (disable/enable), port probe re-evaluates decoder capability via
>> should_emulate_decoders().
> 
> I do not think this bug is limited to "after destroy region". Simply, if
> the driver sees that the HDM capability is enabled before the driver
> loads it indicates that whomever left that configuration also intended
> for DVSEC range registers to be ignored.
> 
>> The existing logic checks each decoder's COMMITTED bit. Since those bits
>> are cleared by region teardown, should_emulate_decoders() incorrectly
>> falls back to DVSEC range emulation, even though HDM capability is still
>> present.
> 
> This is 2 separate bugs, right? Bug 1 destroying the register
> configuration of auto-assembled regions, fixed by your pending patch.
> Bug 2 destroying auto-assembled regions does not clean up DVSEC range
> registers making it look like those are set when HDM decode capability
> is disabled. That unintentionally / falsely mimics CXL 1.1 platform
> firmware behavior triggering should_emulate_decoders().
> 
>> DVSEC fallback marks the endpoint decoder as AUTO, which triggers
>> cxl_add_to_region() -> construct_region(). That path copies the default
>> interleave_granularity (4096) into the region parameters. The resulting
>> spurious autodiscovered region consumes the CFMWS HPA space and causes a
>> subsequent create-region to fail in hpa_alloc().
> 
> I do not think this part is relevant to the fix, right? Once DVSEC is
> being falsely used the rest is just knock-on-effects.
> 
>> Use the global CXL_HDM_DECODER_ENABLE bit instead of per-decoder COMMITTED
>> bits to detect HDM capability. If the HDM decoder block is enabled,
> 
> ...if the HDM block is enabled the state of the register is irrelevant.
> 
>> registers indicate teardown, not absence of HDM support. This prevents the
>> unintended DVSEC fallback and subsequent region creation failure.
> 
> I think this wants 2 patches. This one you have here to always trust HDM
> decoder on setup, and another patch to teardown non-auto
> should_emulate_decoders() DVSEC configurations. Those combined with your
> "do not teardown auto regions" should squash this crop of setup bugs.

Looking at this more closely for patch 2, if I'm not wrong, I think the 
problem is that cxl_setup_hdm_decoder_from_dvsec() is not setting up the 
interleave_granularity on the decoder. It inherits the default PAGE_SIZE 
(4096) from cxl_decoder_init(), and construct_region() then copies that 
stale value into the region params.

So even in a DVSEC emulation case, the IG would be whatever 
cxl_decoder_init() defaulted to, not what the actual configuration is right?

Is the second patch about fixing cxl_setup_hdm_decoder_from_dvsec() to 
properly set the interleave granularity?

Please correct me if my understanding is wrong here.

Thanks,
Smita

