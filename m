Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012048.outbound.protection.outlook.com [52.103.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD874749FC
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252430; cv=fail; b=I4XKH3DbLig+sZLuKKSzPXGuWPpTiEkQhSks4GFHjAVqf3zEidesbm+D8gb10rOBxDAFVCFs6kgCJrHof82GEMK4cPVE5oaZuNtkf7T9ecuxOfCa+eAlpNlleo6v2yEMJ/isgtslg2Z6uZySi+EY1GvzZv54gIcW2nLM9i9T3/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252430; c=relaxed/simple;
	bh=T9zWlA5kvXHm/ttPIFC+fIzE//rH/a028HQ6BQzdQhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2ZGhmeyaRFWoyC38T8r2m7t0qX+8K1oyHMBiFCvw8vidusWgiwvX9u5Folt5wdig9zzKgpm7+UYcvqLbT/iJwnteGW7w6W8RXNDAp3HKZM4+xwufFSSGvRv/kdbwYoA/Qs1izqMGN/qaa0ERm+uSTkv+QjxT4tCZDj5EW8O/Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=H0JMUh2R; arc=fail smtp.client-ip=52.103.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="H0JMUh2R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxXvGfTBI9GIVxFS8N5KpAFUojg40LPr4yyprlc1P87P7OELyK0VnWxNBYZzyy/wdCbAlvc5zTlaEcLvfkmOO32xeLqjofiZb6tthg3exePLCFH7g/SUjuX64Qo1nOP2lfx7sWOM/OwK/4Lzg/f+5Y6V71ZfAgWD5NdQ9c2s7rWtQG9NKM6RV8YAKmpDkbj/ARWvRr6DvVFzvV45uadb4KtpOj6pcQzOmNS7LIMWJvavFKkFoyIAaRq56sUzN962bB8HXhkqnXdx/37YLTc4agi0/Z2xPK8nopCR8PfWRguRg0854u/0Kd7MdF02sFzQQifVvCAaOjJ0vaoJMG3ORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Pg88/0sXW/G8H8zZJZSyXeCuWopeMB4Jaw4vNpJ1+8=;
 b=o9KJuQRWRQ13xNZI70ufAnWuRBu0s0p8KcEvB0nWjk4odieYVhU555uNmXN2PHD2Lpna/bBDq26ADdmuKQmfYCH6bOSc2PTgGHj3n3CPy4hAR4FxFy0yi7Ga/yuRCSznA1Get8hTyLJB3tupO4ToUtvKwOCjFROR6/oW58tBxUiDOUUyn0bzgKCUak38n+x/q+8Wk6DMZsau5EvMNvdLGftETkJlDT+1AfJ5QY/4toYRRjoWyNab215qJ67e52Int0mkLCJSPwIx8DF/kZaRNyHImxURQZ8F1bGEbe8d41TAY1B49KACca03/ZQpSfTepF+AplPM8Y7OHi60IWiN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Pg88/0sXW/G8H8zZJZSyXeCuWopeMB4Jaw4vNpJ1+8=;
 b=H0JMUh2R76jwGdWs7NiZELm1IZx4iEQR4FRnpbV5e959Rq5bfu39/1Bcocmz1o/yZYfetT8Z4khW8/j4FQ9xbdHxTWcv7V2AIlS9AVqpKOQoZxa7PE71az1C+BDnWhtfUZksI+Ax/IKtpLfSzAIwK4SFTjlj/Wk5WUbi5/cA9lGKa2eVizUMTxrJ0JoTXGQTSw4ZFubOyGp91RwGcXXiDg7MlNjQGB1Qkso9bgm0HUgmZ3yXekto5tiKR6wle8/zz0QhKR9BLhjOH5AYG+Z/vFMTbD14AjR+fNUoveBNy/CflLRyHBl8ABsZWraDt7n2H3+U5mecLJ/hXvkbvfiFww==
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com (2603:1096:101:2e9::7)
 by TYUPR04MB6912.apcprd04.prod.outlook.com (2603:1096:400:35f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 12:20:20 +0000
Received: from SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58]) by SE3PR04MB8922.apcprd04.prod.outlook.com
 ([fe80::3450:f139:5238:8f58%5]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 12:20:20 +0000
Message-ID:
 <SE3PR04MB8922CC005D47473207768FD7F3812@SE3PR04MB8922.apcprd04.prod.outlook.com>
Date: Thu, 24 Sep 2026 20:20:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
To: Chen Pei <cp0613@linux.alibaba.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, mst@redhat.com, imammedo@redhat.com,
 sunilvl@ventanamicro.com, jic23@kernel.org
Cc: pbonzini@redhat.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, anisinha@redhat.com, dave.jiang@intel.com,
 alison.schofield@intel.com, junjie.cao@intel.com, guoren@kernel.org,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
 <20260907093735.2753-2-cp0613@linux.alibaba.com>
Content-Language: en-US
From: "Nutty.Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20260907093735.2753-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0007.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::12) To SE3PR04MB8922.apcprd04.prod.outlook.com
 (2603:1096:101:2e9::7)
X-Microsoft-Original-Message-ID:
 <a23d3890-5b5d-4f17-ab61-bbf6bf306ab1@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE3PR04MB8922:EE_|TYUPR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c3dcc2-3b9a-448a-9267-08df1a363291
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQDZd5pLvsexcGXRgbvG27NWtkDZdHuz01eHefeASp3stehSsdjLPYSA1TiX7Wy66l1XhlEYDPAPXQ6SqfFXjSZDYJlkBU87V3IPfHSjVo9Bi8QIIRSYWkOZP9iIeyBapKl/xjVNlynpZVNFfbfU3nHwzyQSI+ZxM3bPesGRXfpiovCKYmftzaisRms5nCBAMRHY2yMY+FHXCocyHymG7Z12IOyLMiNuKI4J87BlThmp6rEl+JxzuxTfe4b6rgnFQ1qxvlda0bKEWpANf1B461E0WazIQ8OPgO1pFc4ZYWId7JYzlqVExcMjWoDr6L2MvwE6TVJdTOr5aZd5hSjgjMbU5HWAcmf+s/LWLh47hadhf6gMuD6xb/bKfez/mc++Lrv8/xiZLIE9CHe35w3Lc5NRwVgTCTjkhjkU9YebOzPC0FQTYWED5gj+m+G0GpsJlUkvm6/tqs02EXc9pz+q5lZSYv6e19M0SxqAc3iwM85U6NzT0Axg+QRxS+hv3qnuGn0sxQRsX32PiAvht7hC05x86rBozKdrjRER5oYoS7Jcy8Hue2mCH2JLn/wYtFyKptITocySNJw8fUXS/7Xak5YtXZMk4TXZPlHoic2ZqC98pk4eszKRk7Xd/Cbyk+0Dm7XaUkdPM3DMusR14hB1kgQSWN6u2KPZbSm1H2dE96EVktVhG5W4yHN7T3Eny2r3CYegb1wNnSirDImQsRSTWxMeyisWKEiRPHVaHdFHWhTGehRsPPq9Q8pZ38wXVm/5cA4U5Doh/Tm6RUdrQpKqa/EilWI4h40kk7fk1gnnG1R6iBCulPASH32t
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|55001999006|19101099003|22091999003|23021999003|6090799003|24121999003|15080799012|5072599009|8060799015|19110799012|4140399003|25010399006|40105399003|52005399003|2607281247196008|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE5XbTVpWnVOSGd2azh1bFZjYzhEbkhXQnhXUUJjWjhaY3dOdExjTEFmeGtY?=
 =?utf-8?B?ZVFCV1lSZTBDVnNqV0RJcGpOWSs2RzVZQWF6U0pPZGtwRmxJT1dhOVhYZ3Qx?=
 =?utf-8?B?RmNBWUcraHc5SkdUUUdlVWVIYkFXWURPMkQ2aU9vakZDNWx5STBZaW1vZkFT?=
 =?utf-8?B?NDBVeVJtdlcrTEJlOHJNbmtkMi82bG9kVjhjd3BNMEErRGNtNzZqZnlhNGZ5?=
 =?utf-8?B?VXI3a0w4azVsNHRsWTZRYlVtL2p0b3NvcUdVVitneCtxN09oRzMwQS9yRVp0?=
 =?utf-8?B?STZBeFNuZ2VabndUYjRRUXZXYmxCcGxRR3ErM0c3NXRIeDRlR3FvN04rbnhN?=
 =?utf-8?B?M0t5ejc4YzU5WFYxdTlMZlh4WTRScjhLeHBzTUh5TExhQUN3NmhrVGN2b1ZR?=
 =?utf-8?B?MkRKLzdGVmdKek5DWENsbk1SSFZDaDFiTjkyOTFUNGRxRllBTWl6cGhWQWZT?=
 =?utf-8?B?T3NjczhOV0FEdVpnWFVUUjNMMHFvakVRMkU2SzdraEVWb1V0MnhGYzZVb0d4?=
 =?utf-8?B?S04yYTNhOEpxK3NpU3I3VStZb2czNUhxTmZWVEtVdERJbGc4MHpTMnlMMkxT?=
 =?utf-8?B?YnVEbWExcWtoTmtqYWEwZzQydXpqK0dSaktKQUhOZWpEM1dZN2pvb3EzUG1F?=
 =?utf-8?B?ZEtPMisyZkhtcFR5TG0vWk1qeFVZS3VZSU5sUFBBSitWb3lIb1YyTnZEZHdJ?=
 =?utf-8?B?eEpZcWFkLzZOWEJHK3pxT3p3RnowaHRsK3BWZXhpZDhnbWdjTUxmYnJlcldZ?=
 =?utf-8?B?T25YTkxOYTBHaXAra2IwZDZsbllncnJGN1l3WW1UalFFRFZLMFo5OFJtNmZn?=
 =?utf-8?B?ZkxUU0duaU9pY0pVR1l4VTJVSkRzUSsyTzk3dXVnWnhXdm9kSjBCSUkwLyt3?=
 =?utf-8?B?eHhzcVJmcGVKdVIyWmpBL0NldUVxNWhpZzNpZjZ0enVLbFNpdCtLN25ROWMx?=
 =?utf-8?B?ek1kTjdibUZxYlZZMjZORmM2VWZGZXV4a0wrY1VaTlR3TGFuOFRNemMwSGdH?=
 =?utf-8?B?dUx4dmJRaURCbWIzTnlUaFNZTXJRLzh6dUkyMEFBc1duQ3kvR3JTTmI5blRU?=
 =?utf-8?B?UktMam1CWTl2WCs2Q2NNRUI1NTFwMjFHWDFiVzM5d2dJNWFHd3BNc2tiRmVU?=
 =?utf-8?B?SFJyZFZMTzB0RXR6RndiSVJkOUltVkc2YUgxdml0UlFlYXNpNDRvMzlvcDBI?=
 =?utf-8?B?bng1L2EwSGpEMWx0UHhTaHE0WldGbXNydTB6NmdjY2crOW1wTXZFYzFKY1pI?=
 =?utf-8?B?WWZyMlVueEtwRXRBRUJTZHVCRldxTGpOb0FqL2I0MCs5WXFpOVI2RHRZMFNP?=
 =?utf-8?B?Wkc2Qjk0dFY5S2NGTzRtTjRsZFN0THdscU5xcTduTlRnbzNSc2ZmUFFEckta?=
 =?utf-8?B?dUdBRklKU2JnbUZtNnNWZjF0N1V3cjFQODRjbFMwTm5oeGMyOXRIVytVeXRH?=
 =?utf-8?B?V0Z0S2VnTW5La2ZwQTgvajFMVGxObUkxK3N3S2Z3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXhoQVdPWDZBQ295cU9NaEpRdTRsR2hQc0k1dTh3UEx3OUQrT3JEcU9SM2tT?=
 =?utf-8?B?WjZGdUtpNTdmQ09FaHNRVitCYU5weDRydTBneUlzbUROWWFFREVxNEZ4bnZZ?=
 =?utf-8?B?RjJQbDhoSUhXMWN3bUdMUDZRMjNzSmZvNG02VHVaY0hMak9IYUc2L0ZVczRD?=
 =?utf-8?B?R3JLU0ozMkdZaWRLTTFYVXNTeG15RGpTVE9rNEpkNVZHbDRhUUlWNGV5YWJj?=
 =?utf-8?B?QnZNRFJEMDlYWU5zWk1zVkthYzhjRkRuYWFSK1h3a1BMNW1oaldlV1RXTmhk?=
 =?utf-8?B?NlVTbWxrYlJET1RIaEd4ZHFsSVBrU0s0UG52Y0VBUUpWeVV1Tk1PM2V0TGtF?=
 =?utf-8?B?VUtRT3lyODd4VXVUTlBUYThOR1A0OU5tNlRWSm1sdUtHUkVDNCswV2FxNXE3?=
 =?utf-8?B?Mk9ia041V3VqdEVsZWU5aVVSaGpEWWpYVEduSGNYZ290SEhOV3lyQWNoREkx?=
 =?utf-8?B?UHl0NDRMSGJQdHFzN1VvNE92cmtHRDFPSFk0bmFnaDdkN2VXMCtNWWlSU1l1?=
 =?utf-8?B?NThNSGFZSTFVNHlObDFrUC9xUDNJSlFFMUppRHUwejVpM2dEd1RUZ0plTm9P?=
 =?utf-8?B?SkIrMVpaSXBTMkltVDhDUU82RjZxMkkxWFV0NXZtSll0Y3NFTjI5NW5ybUVv?=
 =?utf-8?B?S0FKcWd6UFV3MVlkMEZPeEpJRlY4SzM1QTZYakd6NVI0MlMybklqdXNESUlk?=
 =?utf-8?B?QzZpNUt6VnNvTGY4RWlYemVPd00wejd1MHhEbnhsbGZCWk40VWxHRGZkd210?=
 =?utf-8?B?Vkh1aDczWnRGRUM4aUdIdURaVTVuWkJKRWhjNUpwNGF6em92eTNpejVRVHhn?=
 =?utf-8?B?bHVZY1pOK1E3ZTRQbmIxOHMzVDlCbkJ0VWtVODZUVnlySlUwQjlIRnBxendH?=
 =?utf-8?B?dm1DajRqMnpJTEtjcThja3NYWHpmSlRYd0U2ci8zazRMUHdFV2dZcUNUa0Ni?=
 =?utf-8?B?L015bDYwcFkzZzdNZTd1YUFNOXM3Wlh0Q1dtaG5Bay91WGJkdnZrTk5hcGxK?=
 =?utf-8?B?M2RkT1g5Vkd6WWJJdDFuWFJiNk9rUXRVUVVHSDVCcWh0TCtaU2VmMVNNNklh?=
 =?utf-8?B?b0dxODI3WDlpbG9yZUVVNkR2aGF6MFRtYmN3L2g3MVZJY2FINmZsbjFMam1y?=
 =?utf-8?B?a2RuRkwyNDN3dmtxbWNzdkFYbXFkNEF6U0hJTytEN0Y3RDdDRjBuc3ViNHYz?=
 =?utf-8?B?SHAyRWk2eG04YnlxSHRZQjNtcXNacVl1M3JrcGRYYzFrUXA4S2U5OE9ub1g0?=
 =?utf-8?B?STVUblZSNnhCbTFMS05uZmJoV2VlVHR3RkhOaGk3MkFNRk1Kdlc4d2tBTXJB?=
 =?utf-8?B?MWJVZTVyQmJ2MlBsTHJoajJtcEhyUndwYWJjOEo4aDBwa3ErRHNGV2R6K1hu?=
 =?utf-8?B?bktsQ0dVamYxbStjSjNJOGZLN2RhTXVuNFJwTHRlOTVhUXpMVGduaHhMZ0Nh?=
 =?utf-8?B?OWtUQ2kwa2RyTDVqRWNKS0Q4SmJzZUo2czVUcWFhYW55YnJTdW9CYkVBb3hN?=
 =?utf-8?B?aEJQMUFKUVBQTG1peWdUc3FmUjJTSG0vbTdnS3FiSUkyVDFuZ1JZdVJHQVN5?=
 =?utf-8?B?c3hUQkVKVmo2c3d3bmRlbUJZWnVTaWZqUzRmWkoxcCt3OEJyT21kaDhpZUs0?=
 =?utf-8?B?WjNwRzd0R0wvbG1leW4vSWU0VGo0K3Qwem1iQm9BajAwVHR3bkU1dmNLbzJu?=
 =?utf-8?B?c2dXc1BZNTYwUEJTM2t3cUhlN0cvbUU4UmFYRWRVaU12bHpabUkwdUhObXVK?=
 =?utf-8?B?QWhIbzZkMGFFTHNzTmNJaHFvUFZRdEVRU3ZsUHgydW9sUjFrRXRZVnFwM2VT?=
 =?utf-8?B?cS84bVdRWFZDaFFLNEU4aVpHOVZEMWtnWGg0dTV6bjdHdjlOaTlDSnZoOFp6?=
 =?utf-8?Q?jWZHSsKOSCyDG?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-c3e7a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c3dcc2-3b9a-448a-9267-08df1a363291
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8922.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 12:20:19.8862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR04MB6912


On 9/7/2026 5:37 PM, Chen Pei wrote:
> Enable CXL support on the RISC-V virt machine following the same
> approach used by the ARM virt machine:
> - Add PXB and ACPI_CXL Kconfig selections
> - Add CXLState and PCIBus pointer to RISCVVirtState
> - Register CXL machine properties via cxl_machine_init()
> - Create CXL host register region above the PCIe high MMIO region
> - Call cxl_hook_up_pxb_registers() and cxl_fmws_link_targets() at
>    machine_done time
> - Map Fixed Memory Windows above the CXL host register region
> - Add ACPI0017 device in DSDT and build CEDT table in virt-acpi-build.c
>
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Thanks,
Nutty
> ---
>   hw/riscv/Kconfig           |  2 ++
>   hw/riscv/virt-acpi-build.c | 20 ++++++++++++++++
>   hw/riscv/virt.c            | 47 ++++++++++++++++++++++++++++++++++----
>   include/hw/riscv/virt.h    |  3 +++
>   4 files changed, 68 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..c2f8c5d2da 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -66,8 +66,10 @@ config RISCV_VIRT
>       select VIRTIO_MMIO
>       select FW_CFG_DMA
>       select PLATFORM_BUS
> +    select PXB
>       select ACPI
>       select ACPI_PCI
> +    select ACPI_CXL
>   
>   config SHAKTI_C
>       bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 8e516ec114..2be8c6d572 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -29,12 +29,16 @@
>   #include "hw/acpi/aml-build.h"
>   #include "hw/acpi/pci.h"
>   #include "hw/acpi/utils.h"
> +#include "hw/acpi/cxl.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/nvram/fw_cfg_acpi.h"
>   #include "hw/pci-host/gpex.h"
> +#include "hw/pci/pci_bus.h"
>   #include "hw/riscv/virt.h"
>   #include "hw/riscv/numa.h"
>   #include "hw/virtio/virtio-acpi.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>   #include "kvm/kvm_riscv.h"
>   #include "migration/vmstate.h"
>   #include "qapi/error.h"
> @@ -518,6 +522,17 @@ static void build_dsdt(GArray *table_data,
>           acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
>       }
>   
> +    if (s->cxl_devices_state.is_enabled) {
> +        Aml *cxl_dev = aml_device("CXLM");
> +        aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
> +        Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_return(aml_int(0x0B)));
> +        aml_append(cxl_dev, method);
> +        build_cxl_dsm_method(cxl_dev);
> +
> +        aml_append(scope, cxl_dev);
> +    }
> +
>       aml_append(dsdt, scope);
>   
>       /* copy AML table into ACPI tables blob and patch header there */
> @@ -925,6 +940,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>                      s->oem_table_id);
>       }
>   
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
> +                       s->oem_id, s->oem_table_id, &s->cxl_devices_state);
> +    }
> +
>       if (ms->numa_state->num_nodes > 0) {
>           acpi_add_table(table_offsets, tables_blob);
>           build_srat(tables_blob, tables->linker, s);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f3a1cc5ba3..70090ca70a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -56,6 +56,8 @@
>   #include "hw/pci/pci.h"
>   #include "hw/pci-host/gpex.h"
>   #include "hw/display/ramfb.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>   #include "hw/acpi/aml-build.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "hw/virtio/virtio-iommu.h"
> @@ -540,6 +542,29 @@ static void create_fdt(RISCVVirtState *s)
>       create_fdt_pmu(s);
>   }
>   
> +static void cxl_host_state_init(RISCVVirtState *s)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &s->cxl_devices_state.host_mr;
> +    hwaddr base;
> +
> +    if (!s->cxl_devices_state.is_enabled) {
> +        return;
> +    }
> +
> +    base = virt_high_pcie_memmap.base + virt_high_pcie_memmap.size;
> +    base = ROUND_UP(base, 64 * KiB);
> +
> +    memory_region_init(mr, OBJECT(s), "cxl_host_reg", 64 * KiB * 16);
> +    memory_region_add_subregion(sysmem, base, mr);
> +
> +    /* Map the Fixed Memory Windows above the CXL host register region. */
> +    base += memory_region_size(mr);
> +    base = ROUND_UP(base, 256 * MiB);
> +    cxl_fmws_set_memmap(base, UINT64_MAX);
> +    cxl_fmws_update_mmio();
> +}
> +
>   static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>   {
>       FWCfgState *fw_cfg;
> @@ -625,6 +650,13 @@ static void virt_machine_done(Notifier *notifier, void *data)
>       BlockBackend *pflash_blk0;
>       RISCVBootInfo boot_info;
>   
> +    cxl_hook_up_pxb_registers(s->pci_bus, &s->cxl_devices_state,
> +                              &error_fatal);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
> +
>       /*
>        * An user provided dtb must include everything, including
>        * dynamic sysbus devices. Our FDT needs to be finalized.
> @@ -716,6 +748,7 @@ static void virt_machine_init(MachineState *machine)
>       MemoryRegion *system_memory = get_system_memory();
>       MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>       DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> +    DeviceState *gpex_dev;
>       int i, base_hartid, hart_count;
>       int socket_count = riscv_socket_count(machine);
>   
> @@ -871,6 +904,8 @@ static void virt_machine_init(MachineState *machine)
>               ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
>       }
>   
> +    cxl_host_state_init(s);
> +
>       /* register system main memory (actual RAM) */
>       memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
>                                   machine->ram);
> @@ -898,10 +933,12 @@ static void virt_machine_init(MachineState *machine)
>               qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>       }
>   
> -    riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> -                   &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_MMIO],
> -                   &virt_high_pcie_memmap, &s->memmap[VIRT_PCIE_PIO],
> -                   PCIE_IRQ);
> +    gpex_dev = riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> +                                    &s->memmap[VIRT_PCIE_ECAM],
> +                                    &s->memmap[VIRT_PCIE_MMIO],
> +                                    &virt_high_pcie_memmap,
> +                                    &s->memmap[VIRT_PCIE_PIO], PCIE_IRQ);
> +    s->pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
>   
>       s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
>           &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
> @@ -972,6 +1009,8 @@ static void virt_machine_instance_init(Object *obj)
>       s->acpi = ON_OFF_AUTO_AUTO;
>       s->iommu_sys = ON_OFF_AUTO_AUTO;
>       s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
> +
> +    cxl_machine_init(obj, &s->cxl_devices_state);
>   }
>   
>   static char *virt_get_aia_guests(Object *obj, Error **errp)
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e516898f9a..a7b74d10c6 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -24,6 +24,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/block/flash.h"
>   #include "hw/intc/riscv_imsic.h"
> +#include "hw/cxl/cxl.h"
>   
>   #define VIRT_CPUS_MAX_BITS             9
>   #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
> @@ -66,6 +67,8 @@ struct RISCVVirtState {
>       OnOffAuto iommu_sys;
>       uint16_t pci_iommu_bdf;
>       uint16_t num_sources;
> +    CXLState cxl_devices_state;
> +    PCIBus *pci_bus;
>   };
>   
>   enum {
