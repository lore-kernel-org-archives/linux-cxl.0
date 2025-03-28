Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820C2144A0;
	Fri, 28 Mar 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157573; cv=fail; b=INDw68ZBKZlTthvK9abcsS7MGMRK6/+WSVFIgqgPMrRebsHzhY978pdYPpsXBdZZU7yRTy6nOfs/a+9GcouUMoezv9ZbHLlY4UqXgJ8/ZPjhfLsAB/6Xf0mtdlb42a4tg/3tpjehLDJCWeECleH/IKG6K9zggyw12sJSopYpfPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157573; c=relaxed/simple;
	bh=skuH/qoynhCN0pWSg/Ikwk9oNnDOt8Bg8fkYIBwR0FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZT00IGWaxYMuEkxANWBdWrfchQ1M1qpMpGyDn7SnyBspjvb3FKDpi1X0Y1UWmq5jjsm6Xr7/u4hfc1yvOxGA589dj9Aj+qlwRV/5FB9BZ8xH7GBH7FW5/vdqXXy5z5NtNCB97xFtDDBApqDxmm0tVjGHIpoeFTB8zBTmyj5vdDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4mu/t3Or; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4mu/t3Or"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh2aALouxAzb5DeaRY1WNbJGhI/6hqEcuSrWqQRfqK/y9A8bz9WaKoSbuNyMbpTuaFGxXIBGGTq7cD1h40FUKXOHEwfD+bXGdJmmZaI40DPhy06cyyGq8Krk7SskJWwseEjd5Pm9bznnQEylxzOmDqX+lHZY6IURcbjQLRLnxGx5ESFy3iRplzjOK/he9XABMG7+U6edtJEQo/afVkuvq3t5lmmsNb5zTr0D2TIEVY6es+3pB4pEwr5e30K0AJwvMuwT8UQ0WDnu0eIlZJSA4vSZluF1rVuOKD/oVgilbPJ9OwyvEZOtPXyCxYc/EKypF7dkNE9PJqhqzDX3n9hubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiG5JK01sWg5oUufHx+Xqa9KFyOrg73HYkPU+w61b+c=;
 b=iPc89XAkBcpHj8kby98QTVw7pGN3YcVoJoXlvR/jLiHrrz252yOlaAIOl45H/ArLNCJpA2wApcNIGamK0RThCy0UMymKsvvmRo0xWT7arvmGzXJPfs6hPCWe++zRHtT3iUKI1cKd1Z1SUb5MNb4+z4X+1jZD0r3Q9MoPP1IoNWtW+meH7lKcR6vRKKmOz3pCOoeqijUTLNU2FvzL6LOV2aq+fgq6K3R4ahSPJb5sQsiQecUHVgWdPtakzsv6tvNernWDIbtU8JKobtJAxawcZtXsOORv50pcy+hLX1Fo+DNiDjtmGisgxSEO3/hXW6UhehzmTrvOzqDYNQkjrbpwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiG5JK01sWg5oUufHx+Xqa9KFyOrg73HYkPU+w61b+c=;
 b=4mu/t3OrkHqYhfu2HCCSbrupCapWnBZLhKfm/E56cDuit3ZH/3zYdZh6H2YIreeG0AX0d7iY5cjycUvF1YhY9nrscXIwfXWQAGrIhofy3DVWKjVXhIjrnkucoGaDuwHB+qhx27AWqfx9Ne2hs2xmXZPD8JilUK9qazpVfI3o7Vw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:26:08 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:26:08 +0000
Date: Fri, 28 Mar 2025 11:26:01 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4 v3] cxl/core: Add helpers to detect Low memory Holes
 on x86
Message-ID: <Z-Z5OcJ90VDwQb4j@rric.localdomain>
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <20250314113708.759808-3-fabio.m.de.francesco@linux.intel.com>
 <Z909uPbvRVlZ_J1Z@rric.localdomain>
 <8700175.W097sEU6C4@fdefranc-mobl3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8700175.W097sEU6C4@fdefranc-mobl3>
X-ClientProxiedBy: FR4P281CA0427.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b738eb-df67-4c8d-7e3b-08dd6de2f3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVh4aTl1S2NMMmJQL2FScmZEUk9ZQ1NFSldtaVhQMlJ6MEs1SFZvc1VOZ084?=
 =?utf-8?B?Q2JHY3N4VGJldTNCVGtpYzREeGdFTzhMREVVc2dRdU1GVUx5VDk3NmJmVzl1?=
 =?utf-8?B?NElUdzJkQUpOMHBNY3hFRFkwRDg1TzUrY0xXa2xlc2kyeDlvREMzMWREYnFV?=
 =?utf-8?B?eStyMHhWalhzQklsTGhpNDFURlgvM1RLRWtIV29kam15bGdOQzQ2blBydkRR?=
 =?utf-8?B?SDhVNEhHV1c4ckxRMGJsY3lURXRRWEllcnQweXo3Sm1raG9lYlR2NmIwUGVN?=
 =?utf-8?B?ZmlBRmFOWmRUR0pkZXQ4Q3BoK1BueklRQnBTL3J5RlJMZ25Oc3VRZEJnVTM3?=
 =?utf-8?B?WWpNWnNLN0RVVHljK2ZWMWNCVGtuVkNSRW1xR2E5aDlkdGcwSEkyKzRiak8v?=
 =?utf-8?B?QjcweEdnSGVJc0ZzblZkSE5kQ3lRWkZzWGhZY0pzWGF3TVl0M3ptaHh3Y1FI?=
 =?utf-8?B?VjR0cFExL2dIRFBLUmZxZWFXUVFORUNiYmFqZm41R3JQTWtsUnFjOUlRZS9u?=
 =?utf-8?B?SFlVb0VkWmdORVZmbnp0UGV2elRFaDJkeVhMOFdCTXVzeEpOVFVkZGNabVR1?=
 =?utf-8?B?UE5FMEdVeHJ3L1JaLzB2TFM1L1k5STRQajUrQi9LRnoxYStUeXZxVWtFN0xn?=
 =?utf-8?B?dDJWRmY3ajdKTVpiRU1LVFhTWUNCQ1VDd0FsZFk2ZEY4bytZTmpvbTdhZm5o?=
 =?utf-8?B?UmZTRVdlWXJhU0FlTFpFMTd0NFRqbnZTaUhFTXIvbW9wRWUzSVk2MEdsU0Y2?=
 =?utf-8?B?SG1sZ0krMHZhdDB0R1d4YzRtSVkwSXRzMmd6WVNuL1VOSjFaK2k4Y2tsZjI0?=
 =?utf-8?B?bFU3aWhXeDJ1UjE2eEtUQVNrWXluYmZETGlGQW5aUU5UU2pqVzh1NVdweStL?=
 =?utf-8?B?bk8wbFdQc1Y2QUVFS01ESUxyZ0VYZVpONmlHZFlqcXZsUFFDQU5BV3lzU3Uz?=
 =?utf-8?B?bkNKTUFoWGRiaE5SUXJPMko0ZXBFejUwNUFjdGFwMTB2MkpHRmJGT3hOZk9r?=
 =?utf-8?B?MVlrck1GbEZ2amwzanBBamwrbHZpclo0amRlYjNuWHFmMjBrREF3STUrVkNj?=
 =?utf-8?B?QnIrckpjSWJrc1dOanUyNC9ncWU1WGUzcnZjdHptVHV6V1pvOXAzWFVONGYr?=
 =?utf-8?B?V3BGSTRRSEJnZDl5ME9GMmxnSyszUEpEWG5BdXZXdGY0S0VycDkxaFUrZnA4?=
 =?utf-8?B?Q3E0NHBBcXh3MnUxaWpYWDFENGVaSHZiTnA1Q2RzMXFtSEppNWVvOHVmVTQ1?=
 =?utf-8?B?S3NCcVZhNTZtODZLTlJSUGY1ZFo1SDNHdEdDaElDWGdwcXowY25WQzhGbTFQ?=
 =?utf-8?B?RGtvNDZLWDdRb0oxY3NLQzNFNkdhME1DS04yREl2TmJhem9kNXVFQTJzOE81?=
 =?utf-8?B?dTFVUlVvK0ZpT1RpM2Qyb1RWTCtYT1ltNnVZSFd6czlFSmMyM01Ed0hFQitn?=
 =?utf-8?B?Snd2clVVcEpyV2wrRm1qTk5OSDQyOEhqL01xbzZ6M2djWi9ST2M1QmJ4QlVj?=
 =?utf-8?B?L0NEQXJwWGhQVnYvdnhCTm9BSmM5K3JUQ0x3SE5sV1NuNlNhYjU4ajdtWmRL?=
 =?utf-8?B?c2NWNHh2eWJFYTJ5QjY0Q3pOM01VaW1VMFREYnFXZmwvZDQzZzFMcEk0RUxr?=
 =?utf-8?B?RFMyVCtDSzJISkJhNHdsOU1JL28wZUZqSzMwUTRLbXkrbmg2ZHBkSDlJSHNq?=
 =?utf-8?B?L1VsQk9sMzlLSmJnN1B4KzZSdmtRbWJBK0tCNjBzajkrUHhqM0JHMVNjV3dw?=
 =?utf-8?B?S3NSQTdGNWE5M2E1elVtZENia1Y0b25uQzU3TmFPNjJseTFCWGJpTDFkRmoy?=
 =?utf-8?B?V3c3cGZKZHZXSDFKWkRQd0VyaHg3Z0pldkt3M2o2c2x0bFpBK0UwSDdFMHp5?=
 =?utf-8?Q?AE8mmtqEh+KbB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bS8za0pkcm1Rb1MyS2N4SGtZL0N1RHNxWTdBQ2FjRnh2ZCswbWd4VjJxdjRE?=
 =?utf-8?B?UUhFL0ZUNTdvZmZQeXUyMGJVS2dZZ2c3OUpjRDBpbUpRZ092TFdkTGRkWXMz?=
 =?utf-8?B?VXJNS2hsT1FzaW9CODAzTnUzT2JqbkJKOE1BU1pWWGhtWklCU2htbzVHTlZL?=
 =?utf-8?B?dURlMUhOQktUNjNBOTZ4SjdscWk4OFlaSHE3RkgwUkR2dHAzeEZwdjZxb2Nu?=
 =?utf-8?B?a3NwdlRTbkdzdE5WdGcyQm5CZGlvQk40VTdMWTlRV3l5K3ZFc214UTY2SnJ5?=
 =?utf-8?B?Z1doaEtPZXhwb0NoVVp3MHVaNHNQaXFzR0Y0dE1icnFHdHhrMXMzTTJPV3RL?=
 =?utf-8?B?bTFSTTFrUmdVY0RTQVlKSU91ZnJNaWdJV0MvaVVXVFlBaVY2ZVE0YXZHd210?=
 =?utf-8?B?WjlYYVpMaFdISFNNWERtVWJGZHpka1I1cVY4aVpsNUFFU3lOdU9UN1Fzc1JB?=
 =?utf-8?B?d2wwejBoTUZ4bkRacGRsWExOK2JqczQzb2ZlWUdGazE1SHMrb2FNY09ZTVBa?=
 =?utf-8?B?KzVuZG5rZWxaNEszUTN0aWZRN0hZU0NCTloyOVRoVzIzM1FOT2Nab3U5bENB?=
 =?utf-8?B?V0FCUS9EMjBxVUxKUkZ3TWVJQnUwUW1KVUplTVZXM1k5UUh5QThFMkUwcWoz?=
 =?utf-8?B?eVlSSTZYYnN6TXBlWWh2TkNmamdLdkprdVhaNmpPRlFBRkpaNGFnc1VUZm1p?=
 =?utf-8?B?K1d4dTN0WUFtT1FCeTJKNVJsc3NVQkRqVHNCUDFGTzZrK1ZwU2FjWW1BNEt3?=
 =?utf-8?B?RXEzaGlObUxHYmUwZVFwVW5yckRDZHJ3Z251ang4R0Y4V3ZNQXpqRW5IbUlR?=
 =?utf-8?B?ekVTazlyRnZmWHB5d1BldUJNbG5adUdxaXRGcmhuTUhHTzBZZ1dkc3B6d2hx?=
 =?utf-8?B?SmhrdysrVllHWDJxcTE5VHRoeHhYdmZrWmh5R0VEUk5Mdm05Y01BTVV1VVgw?=
 =?utf-8?B?YlBBOUJEU0w4UE1OZVRIMGF0L2JVazlHZHVFM24zQWVEelhhRnBVWkpkZGRn?=
 =?utf-8?B?VUFONDBwd2lhbHc5cUpWK3pBd3RoSUFjVnFENTFFWi9peEtCRmlULzVmU2FT?=
 =?utf-8?B?eVFEekgxbmlja1pqc1NhTFJadkF5enUrQ01WQi9kd3Z6MDZjSmY4MXRXMVFq?=
 =?utf-8?B?SWsya1dEa0tZek1iRW1NMkpSMlpWaW9UalZRT0Mzb0FNNExnRElVZ0h2R0Qz?=
 =?utf-8?B?cmhrV0RjL1F1aWx6MDcxdkJCYUtNSnVIbmx6eWRLbExFR1MzUmQ1WnRrbTdD?=
 =?utf-8?B?dEExSnVJNExGRzVNMVN0c1VYWlVaQlhnMlVIbkMxSmxIay82c2M4cWs4NytZ?=
 =?utf-8?B?V25Tbk1OQytaS1YrUEswaEZBUy9pUmwwdEVlRldIZXU1N0xycjQ0WDJ1cW15?=
 =?utf-8?B?bkg2QnA3U05aWkRvQzBkYUt1eS9wNlpPT0I3bURCTHJuVDJoNWxVQ21xQXFw?=
 =?utf-8?B?bU53ZlV2Q2RrNVVYT1JtajRlUCt4TFpTSEVaT3pqQ2M5RnF3UmFWRzhqWURx?=
 =?utf-8?B?M2F6a1YxK0gySFQ0dkNQVGQ1UENWcUYxelVtdnBmODE1MDBnbmIyT1QrUEV5?=
 =?utf-8?B?V3lvQTNweHpuR2tvOEpQZW1VbG54SklaMS9ieWcvQTdmWU1BeGg5MG5JdzZp?=
 =?utf-8?B?N1RWaUJJNXZTc3hLUkdDejBxdWdFcUJ4cDRqY0Q0aXRSUzJ3b3FaSTNpL2ZX?=
 =?utf-8?B?SmpyRng3bTdaNkhPbXBUT0FPQmU4Ky9qQU1XSkpBdU5XQUxNMHNiQ2QvZFZS?=
 =?utf-8?B?WDlOUjFxTVVmN2VKMUpoMjRGUlR6dis3VEh3Z0VscWlnL241a2hIVXdzemVG?=
 =?utf-8?B?b1FXRDlwL0I2cGtzb2tVUUJKZnFVcXZ4QnIwNkY4R21kY1E3bnJaenpzUXdz?=
 =?utf-8?B?S28zMDNhUWo2UWxWbTJiTkwvMC9GQTdQSTcxTlRaYjBUNXloZHdoSlNrYlVx?=
 =?utf-8?B?bkUwQlZWcGZ3aFBzQjR5V1pVZ05MRnR5WHRIMUNib05pU3pKN2NJTEhGcEhp?=
 =?utf-8?B?a09uY3BCMGQwR3hJZ201ZE9SS29zbTFpOWRORS96Z3VtQ29BVmt5NzBLYTZE?=
 =?utf-8?B?NnZmUUFINlgzME1FMjVKVlNndStORFFUMVB4QjhpemFNMVVWazZac1NFUWkw?=
 =?utf-8?Q?TIK1IUUbgtP9UwMp5FqA9A/hb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b738eb-df67-4c8d-7e3b-08dd6de2f3c5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 10:26:07.9833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rH0N1cbTI4W578aKbf5AyqjKYjjBHngU+9iPYB7QKVZf8D/vvV2ccEcD2uFRNaIdnjldHHBPaAsWf3yIW2E4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048

On 26.03.25 17:47:26, Fabio M. De Francesco wrote:
> On Friday, March 21, 2025 11:21:44 AM Central European Standard Time Robert Richter wrote:
> > On 14.03.25 12:36:31, Fabio M. De Francesco wrote:
> > > In x86 with Low memory Hole, the BIOS may publishes CFMWS that describe
> > > SPA ranges which are subsets of the corresponding CXL Endpoint Decoders
> > > HPA's because the CFMWS never intersects LMH's while EP Decoders HPA's
> > > ranges are always guaranteed to align to the NIW * 256M rule.
> > > 
> > > In order to construct Regions and attach Decoders, the driver needs to
> > > match Root Decoders and Regions with Endpoint Decoders, but it fails and
> > > the entire process returns errors because it doesn't expect to deal with
> > > SPA range lengths smaller than corresponding HPA's.
> > > 
> > > Introduce functions that indirectly detect x86 LMH's by comparing SPA's
> > > with corresponding HPA's. They will be used in the process of Regions
> > > creation and Endpoint attachments to prevent driver failures in a few
> > > steps of the above-mentioned process.
> > > 
> > > The helpers return true when HPA/SPA misalignments are detected under
> > > specific conditions: both the SPA and HPA ranges must start at
> > > LMH_CFMWS_RANGE_START (that in x86 with LMH's is 0x0), SPA range sizes
> > 
> > "... that for Intel with LMHs is 0x0", not true for AMD.
> > 
> > > be less than HPA's, SPA's range's size be less than 4G, HPA's size be
> > > aligned to the NIW * 256M rule.
> > > 
> > > Also introduce a function to adjust the range end of the Regions to be
> > > created on x86 with LMH's.
> > > 
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > > ---
> > >  drivers/cxl/core/lmh.c | 56 ++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/core/lmh.h | 29 ++++++++++++++++++++++
> > 
> > The split of the code in patch #2 and #3 does not make sense. The
> > "interface" you introduce here is out of context which is patch #3.
> > And in patch #3 the functions are actually used, so you need to switch
> > back to this one. Other than that, the code is not enabled here at
> > all, it is even not built.
> > 
> I prefer to split the introduction of helpers and the use of them in
> separate patches.

You introduce dead code here. If you want to split it, then add an
empty stub function that is actually called in the first patch and add
the actual implementation in the second.

> >
> > >  2 files changed, 85 insertions(+)
> > >  create mode 100644 drivers/cxl/core/lmh.c
> > >  create mode 100644 drivers/cxl/core/lmh.h
> > > 
> > > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > > new file mode 100644
> > > index 000000000000..2e32f867eb94
> > > --- /dev/null
> > > +++ b/drivers/cxl/core/lmh.c
> > > @@ -0,0 +1,56 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include <linux/range.h>
> > > +#include "lmh.h"
> > > +
> > > +/* Start of CFMWS range that end before x86 Low Memory Holes */
> > > +#define LMH_CFMWS_RANGE_START 0x0ULL
> > 
> > This looks arbitrary. An endpoint decoder's zero base address could
> > have other reasons too, e.g. the need of address translation. So you
> > need a different check for the mem hole.
> > 
> > In my previous review comment I have requested a platform check for
> > this code to enable.
> > 
> > > +
> > > +/*
> > > + * Match CXL Root and Endpoint Decoders by comparing SPA and HPA ranges.
> > > + *
> > > + * On x86, CFMWS ranges never intersect memory holes while endpoint decoders
> > > + * HPA range sizes are always guaranteed aligned to NIW * 256MB; therefore,
> > > + * the given endpoint decoder HPA range size is always expected aligned and
> > > + * also larger than that of the matching root decoder. If there are LMH's,
> > > + * the root decoder range end is always less than SZ_4G.
> > > + */
> > > +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> > > +		    const struct cxl_endpoint_decoder *cxled)
> > > +{
> > > +	const struct range *r1, *r2;
> > > +	int niw;
> > > +
> > > +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> > > +	r2 = &cxled->cxld.hpa_range;
> > > +	niw = cxled->cxld.interleave_ways;
> > > +
> > > +	if (r1->start == LMH_CFMWS_RANGE_START && r1->start == r2->start &&
> > > +	    r1->end < (LMH_CFMWS_RANGE_START + SZ_4G) && r1->end < r2->end &&
> > 
> > How about removing LMH_CFMWS_RANGE_START at all? It is zero anyway and
> > would make this check much easier.
> >
> I think that in the next version I'll check that the range start is a multiple 
> of Number of Interleave Ways * 256M (it would include 0x0).

The code suggests that r2->start is zero, but shouldn't be the base of
the endpoint non-zero? And r2->end is greater than SZ_4G which is the
case for all ranges above 4G. Confused, how do you determine the
endpoint fits into the LMH range?

> >  
> > Can this being modified to reuse this codes for "holes" other than
> > below 4G?
> > 
> This series enables CXL Regions creation and Endpoints attach for x86 LOW 
> Memory Holes. I prefer not to enable regions on platforms with memory holes 
> beyond 4G until I'm sure it's needed. arch_match_spa() and arch_match_region()
> can be easily modified if in future they need to be.
> >
> > > +	    IS_ALIGNED(range_len(r2), niw * SZ_256M))

Isn't that length check of the endpoint always true, since this is a
CXL range?

> > > +		return true;

The whole check looks odd, please clarify.

> > > +
> > > +	return false;
> > > +}
> > > +
> > > +/* Similar to arch_match_spa(), it matches regions and decoders */
> > > +bool arch_match_region(const struct cxl_region_params *p,
> > > +		       const struct cxl_decoder *cxld)
> > > +{
> > > +	const struct range *r = &cxld->hpa_range;
> > > +	const struct resource *res = p->res;
> > > +	int niw = cxld->interleave_ways;
> > > +
> > > +	if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
> > > +	    res->end < (LMH_CFMWS_RANGE_START + SZ_4G) && res->end < r->end &&
> > 
> > Same here.
> > 
> > > +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > 
> > Right now the default check is:
> > 
> >   (p->res->start == r->start && p->res->end == r->end)
> > 
> > Can't we just calculate a matching spa range for the decoder and
> > region and then check if both match? Both match functions would be
> > obsolete then.
> > 
> I prefer to keep the design untouched. Anyway, I'll check for other aligned 
> res->start, as said above.
> >
> > > +
> > > +void arch_adjust_region_resource(struct resource *res,
> > > +				 struct cxl_root_decoder *cxlrd)
> > > +{
> > > +	res->end = cxlrd->res->end;
> > > +}
> > 
> > This should be squashed with arch_match_spa(): same style and
> > interface as for cxl_extended_linear_cache_resize(). Please generalize
> > the interface of cxl_extended_linear_cache_resize() first.
> > 
> Do you mean that arch_match_spa() should adjust res->end? I don't think
> it should.

Yes, it should follow the style of already existing code with unified
interfaces.

> >
> > > diff --git a/drivers/cxl/core/lmh.h b/drivers/cxl/core/lmh.h
> > > new file mode 100644
> > > index 000000000000..16746ceac1ed
> > > --- /dev/null
> > > +++ b/drivers/cxl/core/lmh.h
> > > @@ -0,0 +1,29 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +#include "cxl.h"
> > > +
> > > +#ifdef CONFIG_CXL_ARCH_LOW_MEMORY_HOLE
> > > +bool arch_match_spa(const struct cxl_root_decoder *cxlrd,
> > > +		    const struct cxl_endpoint_decoder *cxled);
> > > +bool arch_match_region(const struct cxl_region_params *p,
> > > +		       const struct cxl_decoder *cxld);
> > > +void arch_adjust_region_resource(struct resource *res,
> > > +				 struct cxl_root_decoder *cxlrd);
> > > +#else
> > > +static bool arch_match_spa(struct cxl_root_decoder *cxlrd,
> > > +			   struct cxl_endpoint_decoder *cxled)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > > +static bool arch_match_region(struct cxl_region_params *p,
> > > +			      struct cxl_decoder *cxld)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > > +static void arch_adjust_region_resource(struct resource *res,
> > > +					struct cxl_root_decoder *cxlrd)
> > > +{
> > > +}
> > > +#endif /* CXL_ARCH_LOW_MEMORY_HOLE */
> > 
> > I don't think we will need all this helpers if there are platform
> > specific callbacks as suggested in a comment to v1.
> > 
> > -Robert
> > 
> As said in a reply to 0/4, I'm not yet aware of issues that would interfere
> with non Intel x86. Anyway, I'll think a bit more about using platform
> specific callbacks, even if currently I don't think they are necessary. 

Please do, thanks.

-Robert

> > 
> Thanks,
> 
> Fabio
> 
> 
> 
