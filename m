Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79233368A4;
	Fri, 31 Jul 2026 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480557; cv=fail; b=lIK5zvPRD18xfRcOygYnXvsnFVNgJZiZ+Pt9dD4OH7bwp4ZxE/Y3PGhXzg6l2imyzGNzigGQ2Wuc7hDV9sT8NxcrzxPpIHEmq51oqAaRBGiWa8bx8zn8AMp59wjPEJtc+2c/r9Ni8HhjiDZQY5mNsnUAh9B+ddahM88bwo8yHKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480557; c=relaxed/simple;
	bh=NQHu3qH6a0iMuX5M84yZqoQpsGBBiznGvvxtw3WRKHU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ITT95jRONBPt/xPTbqHK+F+/F5nVifA5okzGJy5XQ39QSJQizQM0XB+XVPqS/Z0zu5Uf4pLbFz9XgvqpEpVdKzRoQScmfG0R1Nsqs614LGz11hcyteCRjaY+WZozSffRWHR+1XiHl0fVMdMk7MeAHVHd7pnPs/HczbgvlI6o+Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sD5XMOg0; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sD5XMOg0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jvr68WnY0QvCFVqM/qjGF3Ka7Gt8kQgsbjHpouN71UJYunyxZTfTNsAZYInMniqMZNKREj98WqZDmOeKYdWlyltVq8AXIiD9rA+RUAIoz7ZOxWCPmS6fmZN3cqxUnWftRT19nW+K2bpyqBTWUAHWzidLLmev6yMdRBbRunqz5azXRLKJXOByLHSFuwAbm3Z9hs37Bpo3AnTgJtYrhe09UH42/yVIwrjpkkNMiVXM+Xwu+VhtkICzby93Lk04lDbEEUD90oXIUoIFVW9PBT8FaQyr6w7pbXP66IbF3bVUV6/n5Hv71622fCS84wkAdjEerWlYOJR0DenLE9bOTCm8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+clyYPsJgMmc3wAvEewBEcaZckzzFa9Tccw4eNq5IgE=;
 b=MH/1KIoLwnzQrgcH2o/vOSFqKmStlYuxJ3XpDwB2413TncadEnJr24loTzAVHa2/dht77bB0tksDn31382fBGAfzIm2hqgQoNxH4xUffLNx3/eMx88xNFFEMieHzlxla3KscqU8wMiqGOqGfRH6tI8pDvTCzmist0z7cpWAxbN4KjzpTVhhV4mbq/QqFKQCnGXjYl4LKE30XvlCcQTNUy+2fxrDsLKqN5UTqcn9cebmTT30sovOo4MqTcK/m7Fk0VPMp3CQFSLr1sK7o3yJD1k8NW/1gh5GGcJPDEL/h1zZH1x4SqeQ0Gm+z8LLI/JaHLF3QCrEvsG0yfmHggs7e1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+clyYPsJgMmc3wAvEewBEcaZckzzFa9Tccw4eNq5IgE=;
 b=sD5XMOg0qXAchS5C4VGbx6CldSXxDC0ohvUj2GXrV4B/o7GJ7PMw5QtvN873hqrjIEIe0Hg9pmFbPWqyxWVpqHFUyJ9Tccq902fQD2gFTkqV9a/sTrtyTEQN4+AQLRsONUsKYcFP+pOcbsVd2FZAdCFRjVyOcqu1ufOBXPu9yxZw5mPJqpRnzbvjV+veA2Wqu3OFbFQvS3eKz2qcPdsLyswI1J+dcpbmRokvWyOpH+39bPcwp4Ny3pY/Dv03MAeI45asdJVsaK7a7IxZ2+skI0P902yUN3k9O/w6GLsOdBD+O4uR4hvgXhQfXrHQW5fupCbih5kdbqNCc13lmBXcYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 06:49:12 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 06:49:12 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	mochs@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v8 0/3] Support zero-sized HDM decoders
Date: Fri, 31 Jul 2026 14:48:59 +0800
Message-ID: <20260731064902.34127-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0056.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: e25f7ade-7d48-4e53-59fc-08deeecfd3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|18002099003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	kkNJwCOJEqKEDJHd92gsq8ix6Wb/HpA8YuwOkTdjap72Me4wUOeSUjNqPJYpLZxHJXBcoOqFWk7Q2ax1C77UMg6yc9HwEnnlU0lKBC+NT8g/lCtBvs5fSoYqbmAP6gy64aew0Vu+oecx8gaAMDtFTFDAuH4RegDC796RLaKw9lAsXu80Qjg+gDeM9gplrypN3qWdDbhBMc0kil41qQmcspzTSosixEkwlkyIvJgz5ANkGvSV1mtBEPTPimBc0vKhZDUBzJGTGdCpf3LUoFoKOJzAyMkT/7wbqU5UQJ2YfXYz9zGTA+HgirZqH9XE4KM2ONRClEVyX5DZl+j24MM1fVyRIcodgsz9hIBbrfms26WsRz6SAwduZSpUAcdHMBqO+XnGyR1SEe1M5PHieTjYirBjpWLSA7O4Qr0qGUktk9IxMpl2apGYLT64ThdTwKTCCzh/ELQuoKyo2P42NMsqmCABTsH9R4nTVz7vXKvtNSNHr8OBkgo6xJ/4NNMzboIk9CUmqAtPN7EzivFYhwbUUvtW6EpnFdi4LvOdriymfxYHjp5hFjq9c1eJ8fEIuV1hAtKNKwyMZnXqEBdIPArsalhnEWZT9yLnegGO0L4hIcwIf9UYP3TvN47nQE+bk0u9FtMySbAHzD/qZDCauXoNjTYhSrxyLHEFR0MG/b9wqtA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(18002099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUhnRTgrVUhjUWs5ZUNmdXJoVndVeGMrMHlGSUtsNmR4U2tLdWtHaVdvWlY5?=
 =?utf-8?B?M0hNcUVNUFl5cUJZcGg1ZEtFWjJpd0RmcXcxQkFtNitmZ2R2amRUNW5CL29t?=
 =?utf-8?B?NzhhaXNEZ0J1d2QrRnZ6V1d5YVo5c1RnbzZqalMyZ0tPdHpHelBSTUcwdU5n?=
 =?utf-8?B?bUwrUjRSeDM4ZDgwK05NUVlSbEhyamZ0YnV3S0JnaGpPelUzSlRzaTdzS0ts?=
 =?utf-8?B?QTQ3bnNKcTRJQXc3L0xkY2VXTGZzL0lvOHVFRm9rRWhEbTVXYVpyZlBad0dk?=
 =?utf-8?B?bHF3OGQrNUlaRm5tc0FyNW95UzREaXVTbFFWM0VDSjF4OE9QYVdNdTFYSnI3?=
 =?utf-8?B?aGo0TG9HWllkNVhDRGZEdXBtNlpva3MwU0xEL3BxZG9iRTdpVkp6TktVeWY3?=
 =?utf-8?B?VlpoWngyWnJJbE9iU3dieStxN0RVUlNWaFlNa2x0RHNrU1FpNU9RVE1DZzNr?=
 =?utf-8?B?Nm9wY3phMXl5empTZ2szRXFzQ0hDZlIwc2hXR1ZnWmZTaUtFbDRGaE5HaEtS?=
 =?utf-8?B?SEllZGVTbVljU2craDZ0V0FZYnpOcFlFT1NtZDdYOW5FRUNzay84dkFFUnVj?=
 =?utf-8?B?eUtyNEx4c0FybWczSytGdjlNaXRmeWhmWE5kRysrazhSdVZTblI5Y2J1SHMz?=
 =?utf-8?B?OWZsWGczMkE0c2FPSVVtbEs1SXhoNkxTNTdsaklZalAyNHVHdWFqQzR2YWhO?=
 =?utf-8?B?R2NaQ3F0UzlNL3lNcnBTdFNJQ2hwNHhTTEpHOW1zSXh5K29kNWFhVFBXTU5w?=
 =?utf-8?B?TWFta0FDayt6UXl2eVF5R09lVmlzQm8wV2RnWFVKOEVIUUNuZ0pxbGIvdStT?=
 =?utf-8?B?M2tpS1h0RDI5Q3dzTS85dHRSaC91ZUk5cHk4d3ZVQm1PRTdzZUx6R0tlYktQ?=
 =?utf-8?B?UFZuWkdNTnlOTmtyRXFrZVgwM2tJSkcxODJQdmYvNGpSdGh4MDIwV2dUdWZi?=
 =?utf-8?B?SWdrZjQ2bXBIRHJ5V3JGb1Y0OVpveTNGOE1GNDU0T1MrNFVtbTdrWHlBbXpO?=
 =?utf-8?B?ZlBPdEtibkdCRjNMVzN4bTRSbGdxUmhCU3BWZmNsTmw5OWlVdUplajNTcDhV?=
 =?utf-8?B?QmZGYWcxVGFwbndSdXpMbHhhSUs5eEpKMWQzMWhXbWVNeEFHN25RRHo2MDRM?=
 =?utf-8?B?YXlrSTA0cERoK2k5a2dUNVI1RmhMazUyU25QblZUdVVJa3p6R2U2OEhFQ0kw?=
 =?utf-8?B?OE51MFFYNVI2cCtRSnFBOHdjeWtPU2V5QVNSRU8zU0ZhQXRycGpGcTBTcHor?=
 =?utf-8?B?OUlndW5yUDl6dkNKQlUvckJYM0VtVVVxYmhXMlFZT1VZNEdMcnFsMzNIQ3J5?=
 =?utf-8?B?TTkwM0ducVg2TUV0ak1oNk11YmRRUlpjMDRFcHFpY3hjUVF0MFNyWGNXUngy?=
 =?utf-8?B?bUdxbVl2UUlPWndZc0tQRDgvY3dBNy80bkc3YzNxODJyV29jL0M3UXZDTHVX?=
 =?utf-8?B?enpIMU93U1NHNWlSRyszVk5vY05ESW9XNXhyUm1EaE1SM0d2eWEvbWV0YXVk?=
 =?utf-8?B?MldiZFFqMWZxUEJJTUZPWUhoMEs2OFBTWjBWTC9lMzVyYk02dXgzclR1RUVD?=
 =?utf-8?B?QW1QTUZEN1hmTzNFSTdCcUg1aXZWMWVuM2Q4Zkl4RG5qN1pkT3FzUzdGMG9x?=
 =?utf-8?B?NnpCeEZTa3NvVWR4VHptbS9EWUJwWGNlbzdaMmhjTkpqcFdlYnN3L1pUU2Rl?=
 =?utf-8?B?ekwyT2VraDU4OXVSMGJHQm5McndzMGg0bHIyaUIyVGloR3ZaWEQ4Q1dZaTlS?=
 =?utf-8?B?eU5mVmpMUnUybk90N0V1enl3SjNreWhJRzhjcWxOQnY1Zld0bmFINkhkN3Nr?=
 =?utf-8?B?V09nRm5Hb3dySVlRNUE1djhqbEhveFBRa1kyVy8vaytUcGFweXZJNUZkQlVC?=
 =?utf-8?B?NnpnMDJERVhaNEdENjhGVThka3REOUZJY0lFdGZ3dTNpbVVXd2RoWWF2ZHJE?=
 =?utf-8?B?QnRUaXczblhreWhPTnBpSkdYd3B1S0h6ZitBRHZYNUNScENYalptZnZaVGtR?=
 =?utf-8?B?SnlRU1FGcFNOd0RRTm5QcmtxV3hJaVlqWnN6UWxOb1Q1azBZQUNtYWJXYVFs?=
 =?utf-8?B?ZFJrZ0cwS3FEOCsraE5oY2xKVXFaSi9mSzJwd0hFYWM5NUY0dUF3VlQzck92?=
 =?utf-8?B?Tm9Sa2ROYjFLbDVBRDRMcVB2VDdWNHV0Qk42SzdKYXF2T0hTYmxmMnpQV0ta?=
 =?utf-8?B?dHY5RklKTFgrL2tsOU1VRE1VMGhQbXJ5YzFTakFWVzRVbDBjNlVyeFFkRWtt?=
 =?utf-8?B?cVNFT08wWk41Qi9CbjVMeVV5dWdXSXlIT2Z0QTY1SGdQMG42SlBNWTJqQmlZ?=
 =?utf-8?B?NzhzbEFqUGU0Y09jT1M2N3pSMVdCSlNNVWpJT3hhaDlhV2RSamgvZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25f7ade-7d48-4e53-59fc-08deeecfd3e3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 06:49:12.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8ek7sFDZc/8Lr/MR2fb+eoBdPFwCuSauoCIuFyuSehTEnd2yxVdtVTlSpM2tpkhi57fwscNLA5QzMCZse5J5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

CXL r4.0 §8.2.4.20.12 ("Committing Decoder Programming") and
§14.13.10 ("CXL HDM Decoder Zero Size Commit") permit committing an
HDM decoder with size 0. Firmware may commit and lock such decoders so
the OS cannot program regions through them; this is a platform design
choice rather than a specification requirement.

The kernel currently rejects these decoders with -ENXIO during port
enumeration and aborts enumeration of the entire port. On affected
systems, this prevents the CXL topology from appearing in userspace.

This series enumerates empty committed decoders into the topology while
keeping them out of region assembly.

Patch 1 is a preparatory cleanup with no functional change. In
poison_by_decoder(), "rc" carries both an error code and the loop
control signal for device_for_each_child(), so returning it bare is
misleading, the early guards mean "keep walking", not "no error".
Zeroing "rc" to forgive an -EFAULT on a RAM partition adds to that by
discarding what the device actually returned. Return a literal 0 where
the walk should continue, and test the forgiven case directly instead
of rewriting "rc". Patch 2 extends this function, so cleaning it up
first keeps the functional change free of unrelated churn.

Patch 2 makes zero-size DPA reservations first-class. Since the resource
tree cannot represent an empty range, an empty decoder is backed by a
separately allocated resource. This keeps port->hdm_end, skip handling,
and in-order DPA accounting consistent. Operations requiring non-empty
capacity, including region attachment and poison queries, are guarded
appropriately.

Patch 3 adds the mock_zero_size_decoders cxl_test module parameter,
disabled by default. When enabled, it installs committed, locked,
zero-sized endpoint, switch, and host-bridge decoders under
host-bridge0.

Tested on arm64 with cxl_test and the ndctl unit suite (ndctl
v85), on a kernel built with KASAN and lockdep enabled.

Full cxl suite with mock_zero_size_decoders off -- no failures:
"""
$ sudo env "PATH=$PATH" meson test -C build --suite cxl \
    --num-processes 1 -t 6 --print-errorlogs
 1/16 ndctl:cxl / cxl-topology.sh       OK                7.81s
 2/16 ndctl:cxl / cxl-region-sysfs.sh   OK                5.28s
 3/16 ndctl:cxl / cxl-labels.sh         OK                3.27s
 4/16 ndctl:cxl / cxl-create-region.sh  OK               10.70s
 5/16 ndctl:cxl / cxl-xor-region.sh     OK                5.76s
 6/16 ndctl:cxl / cxl-events.sh         OK                2.77s
 7/16 ndctl:cxl / cxl-sanitize.sh       OK                5.73s
 8/16 ndctl:cxl / cxl-destroy-region.sh OK                4.16s
 9/16 ndctl:cxl / cxl-qos-class.sh      OK                3.25s
10/16 ndctl:cxl / cxl-translate.sh      OK                0.94s
11/16 ndctl:cxl / cxl-elc.sh            OK                4.21s
12/16 ndctl:cxl / cxl-dax-hmem.sh       OK                4.56s
13/16 ndctl:cxl / cxl-region-replay.sh  OK                8.66s
14/16 ndctl:cxl / cxl-security.sh       SKIP              0.02s
15/16 ndctl:cxl / cxl-features.sh       OK                1.42s
16/16 ndctl:cxl / cxl-poison.sh         SKIP             11.23s

Ok:                 14
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            2
Timeout:            0
"""

The subset Alison asked about:
"""
1/6 ndctl:cxl / cxl-region-sysfs.sh   OK                5.28s
2/6 ndctl:cxl / cxl-create-region.sh  OK               10.04s
3/6 ndctl:cxl / cxl-xor-region.sh     OK                5.67s
4/6 ndctl:cxl / cxl-destroy-region.sh OK                3.77s
5/6 ndctl:cxl / cxl-qos-class.sh      OK                3.22s
6/6 ndctl:cxl / cxl-poison.sh         SKIP             11.52s

Ok:                 5
Expected Fail:      0
Fail:               0
Unexpected Pass:    0
Skipped:            1
Timeout:            0
"""

With mock_zero_size_decoders=1 the topology enumerates with no -ENXIO:
11 memdevs, and eight committed locked zero-size decoders. Two sit on
each host-bridge0 endpoint (decoder16.1, decoder16.2, decoder19.1 and
decoder19.2), each with dpa_size=0x0, that is a real zero-size DPA
reservation rather than a bypassed one, mirrored on the parent switch
and host bridge (decoder1.1, decoder1.2, decoder11.1, decoder11.2).

Poison by memdev by DPA on a host-bridge0 endpoint returns all four
injected records and clears back to zero. Teardown, and three module
reload and unload cycles with the empty decoders live, produce no KASAN,
lockdep or WARN output.

The core patch was also validated on a Montage CXL Type 3 device.

The corresponding ndctl test is attached at
https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/

Changelog:

v7->v8:
- Split the poison_by_decoder() readability cleanup out of the core
  patch into a new preparatory patch 1.
- cxl_dpa_request_region(): split the declaration from the allocation
  so the allocation and its error check sit together.
- Add the missing blank line between commit message paragraphs in
  patch 2.
- Patch 3 is unchanged.

v6->v7:
- Rebase onto cxl/for-7.3/cxl-type2-test.
- Patch 1 is unchanged.
- Adapt patch 2 to the refactored Type-2/Type-3 decoder initialization
  paths.
- Integrate mock_zero_size_decoders with special-topology parameter
  validation and reject its incompatible use with fail_autoassemble.

Richard Cheng (3):
  cxl/region: Simplify poison_by_decoder() error handling
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoders under hb0

 drivers/cxl/core/hdm.c       |  55 ++++++++++++------
 drivers/cxl/core/mbox.c      |   3 +
 drivers/cxl/core/region.c    |  57 ++++++++++--------
 drivers/cxl/cxl.h            |  10 ++++
 drivers/cxl/port.c           |   3 +
 tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
 6 files changed, 182 insertions(+), 55 deletions(-)


base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
-- 
2.43.0

