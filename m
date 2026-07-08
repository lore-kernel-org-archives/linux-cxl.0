Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB83CCA11;
	Wed,  8 Jul 2026 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507245; cv=fail; b=Uee5QRFtBYRQZxRpnRpsLf5GdDRrgTG+YbSyjhJuxOpxW51h/XPZGkUYV9ehMeSnnc0706bC8sQ8ADLKloISGvCUCWuDandWT2h2zC+KuTjMY0jLEm/wkt2ZLXEvLfjLcQs7WoNk4pnU31SgagxFhvrEXlOVqeT1ELjxAJrO7j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507245; c=relaxed/simple;
	bh=YTaTbyJhsIGQE5bzeIKdqwONaPNLME9aAljIXMBxK7k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=stujg0pgiVfcQe3u/ryhR7/MVbWUbx29mtr0K5Wc4ZfOGeOo3F3N+SN77PqnJDLmnJc/MoWbiaj2BIoe4LjE3ej3+UjXMkG9/ZnnXyGAw5raS7wrtnTAttF0UVDX5sNYaZXNP3XNNCcWhPm/h2aCXJyoiw6XVQLWxZLjxdhDzMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d49Hy2Ml; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d49Hy2Ml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voXz4PP/iywZDvlNnc8hTM8slnOhuc1XPgFleTibQIR8VXwZxFzeWUl0sptDGj1sfAfvy90ZfrSPidWM0QfrVwyn9d6FNoHS1VY9cG+U+XBIHULvkmXhjVBG4Gg/i1JxxkCyAZHUGu8MGAX/9qTA59nlVm0X10y2fob0gE98FbR3LCle6WzO4Rxxi2Vq+zE6YX+5WqGZr31JrLHL/1rH06heRQ7N8A0rlxFJ5fEpoYzHmq4T0R5bt2QHDdCnGTiGUqbVLDrKwgVaeTr08Al4FJMxYJrz+/hLIS9q6UtLcp1QL0Es8MOoU8qnj0pArGZIYdoTsPkoXb8rV3k4vjrwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77WKKmyyvLrdt9PBQG6M5BOBRi7WSJWDXfCNTNmDRNQ=;
 b=ZzojKCQP57RbaJNhSp3W54rrqCueaMUgp5v0Whk1gfNpth171CNcktvqmbWnfbF9xnUburwaeAuEqidaS6nay7jv/6skXzmhgMfLm23jx2AGdn84EIA/gyib5II+BpMVjEOIeEcW3mIoA/0abzbuQv4Azzb+OpemuCfucFu9GDYF4dVn5r7vgiNjZsGl1JvAU2kDkP+wTUe3932/M0BYnkX+H1HS66vmPm+S07/Ed9K9BzNHtopXAM6WNjFq1vs9Ui3Wr6AgI9nMhpxb7pWi7QJlDX5bXkj9bU3CJvZMwTxnbRTveEF1vUxbXSrPqaWw/akqXdx7F3EXKe4+2q/i3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77WKKmyyvLrdt9PBQG6M5BOBRi7WSJWDXfCNTNmDRNQ=;
 b=d49Hy2MlRnTJL/jtC6W6v01HnsoKiKfOBjX+6NhjK9OxpPi/orOz/+BL0vI6cIfvx4FOdmhWArq4Z+pVfiRbBl/c+SeEPNP3SfUhyZlekM936eNBpiqMyiGsOEfRGke5E3hTS0VM9qtU/MycolQkTTDNkoK6HImAXxRFA8VR0efhLYCgT7aRVX144K+efCiCc8Hd0hlUzTLXNwil7fcAlcnQFX4KntXUDY1iebVTYVFEvJE8C4h1e1SLC5trfC59ORyWpvXhY+D33dHv3KPrGgNk4JgU9ovKWssam1qP04umsdaTR+twJc1M/9/lUkgU+tOu4pSAV9/3B6MOnrQh2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SAWPR12MB999294.namprd12.prod.outlook.com (2603:10b6:806:55b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 10:40:31 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 10:40:31 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v7 0/2] Support zero-sized HDM decoders
Date: Wed,  8 Jul 2026 18:40:21 +0800
Message-ID: <20260708104024.68029-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SAWPR12MB999294:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c57a53-6cf2-45d6-07e5-08dedcdd550a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	COJSSvUHOmsUZj/M16Ivt55fA1opf8B4W8PYdE679zqzsErJZg4ySn4nFTxlnB38mT+qrXuarYLlkTFYZolSkTewxx32P42PkNub/FICALMu3ChaU8H2MHo6W+HWPz6SxCE1tCbt/LSYIHtpZ3Bu8CFd4Aus0WhMX+7hiFoISvTk1R2c6H8oI7I1uxTLHvaENtuMe/w0fceCAzxzKocqtK+pwnYev8WXcdpRXKoJzaI3VdbkmqTNt/psIOF4pWF0rm+4GNnMfgmRxd5HuTISQYqVyFyvERgvNj5TfZG8eXv+moilbgH70rb3xfsuQ6WWEP1V4mUzlzGrLAWkz1TJ/fEW5B2eOJSje6WNqkSgTgwm5xnvZje9aA4+qM6nNDNJ7QWxxxN3nSBBtucJQLF2X3DpjGyGJhc5tXTqc6EFoHacYejSAxHV2aPI/Mm665s4uL2/FCG7hRJfCDAL3hzfZxdzooqwhAOI/f4HOQndyMr6pep51oEwFizzzsSeuwEMsVPjPMdn6w3gf0RUn/LUpXo/YFYslkSuc7rIlgpZfJU/bgj8kjPDjR4VQWzKEfgUFO06mv0zbFn5MICTREIeKg3DqQPOATFLroQgAad3z68CR4wDyXvX4jnN7iQNkW04xUoHAom6jC0pLvCFA9cxLfDpSMcZX7c2/BHQEISXmO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlZTMUFkNGZpeGhmNHVVUVQ3TG5XbkZBbXVrSTl3ZEZhemI0VnRKOUdxaElJ?=
 =?utf-8?B?MkhLbXZSbU1DOTVMOXhTKzdkWnROOTA0MHgzYnJMNGt4QXFxazNXWGRDVWFE?=
 =?utf-8?B?bUJpbUFCNGI3NGEyNWQ1WVFKQWdGa3RrYWdTRnlJYzdCNEdaN3U0V295Qk9m?=
 =?utf-8?B?eUFqK3JYa1RGTzVYd3krL0UxQjk2WHVoOHltT21TbmpXQkQwVlR2cTFoUmYr?=
 =?utf-8?B?TklFOWtRc25zdGlaNVlvTHNDSU4xM2JiTTliczBSYXh1VGIxWEtpTW9HTktC?=
 =?utf-8?B?d3MxSDdiUllNZndBQnZzR0JhaEk1YjVhT09mNVZNMVpwdU1hQ2UwZmdvVFV3?=
 =?utf-8?B?Y0tUenM2SVpOZ1RYNGVqR1hoOWRDbTU2T0lwOTExNnBFWW4yU1V2allEQ2ZU?=
 =?utf-8?B?SStETFpPK0M3dmdzTVM5ZkVMRFZhU1A1dFVjakJHTVZPWTFCZktNdXdMcHpw?=
 =?utf-8?B?eG5zNmhLT0V6b3JxdXp2T3RlM1RSY2xZd25Qa2IyKzZqRzlWMHBaajRGaUNV?=
 =?utf-8?B?NzRyQjdwWk54QzhSQlRsL3FEWG11ajNhOTlaVGllZEEySklaV2o0ajVuK0Zq?=
 =?utf-8?B?Z0EwV1VEajRtejJRT0o2NnRCUGlXeEdjNHRVTmpKUGROVXlRUEk4L0JiR1Vq?=
 =?utf-8?B?b2NZUURYSHpNUkhkanZqVEpZaW9mT2RRTnN2WmhQbzZ2dExnaFo2UTcyZEw4?=
 =?utf-8?B?STQvcW9nM2MwN1FwREEwM3pFZjVEWS9NSyt2ejU1cFc2SEFGMm81REhoeHcw?=
 =?utf-8?B?VUhvN0JvVyszaG8yT3FDUk5CbUZIR0J3YUxrakZhVjF3UFBvWEsyUm1Rd1Vx?=
 =?utf-8?B?VEFhZHVldUlaQ3dIQ05Zcm8yL3JFS3hCa0JSYTJsSGN6ZVFtb0syemdROGta?=
 =?utf-8?B?ZzVSazZUK1Vwd0dIZ1cvWXNzdVV0SGtKN1dNdXhDd0hzN1krT1MzdWp2bllu?=
 =?utf-8?B?QXIyT1VoempGL3NTUjBCSEhDdDZLYjljMldLVWVrd0F4dHZET3QxVUJidjNJ?=
 =?utf-8?B?QzdGMkNiNFBnd1hxYzkvQVVkNlBER3N0NjdCSnJDbW1yY3dqT1BFZFhXb1Zo?=
 =?utf-8?B?UzhCbGVyNC85MDRnb1JGQmRGTXkvanNUTlVydWxubzFQSUE3T0hHWk5NbWp1?=
 =?utf-8?B?V2w5NGdHTElnd2FKdXVjNDhLd1ZQUGMxU1pObGtySjhoTUE4bCs5aVQ1ZXhn?=
 =?utf-8?B?ak9kZUdZVHhueTh5TndkVEtmdStqcWE3VU9TdUo5ZXNac2x0ZUd4NnpTdDcw?=
 =?utf-8?B?dHBjWmxkSEFEZE5lWDNqb1RKMEJoTGNmZWxqbHpZbW13Uk00eFliOHVibmhv?=
 =?utf-8?B?M0c2NktOWUpCT2FrN0d4U0l5RmJYbHdUcHhSbGZETkkwWHJiUU1HMm9WTnpP?=
 =?utf-8?B?bXNKamNVS1ovL2pqdTdXSXZKUjBJeWdLUnVHeXo1MUdSUCtiT2xLa0tZL0ta?=
 =?utf-8?B?bHhLc1NFUTlaY3dKYWJGQ1lGajVkYXdGT3Avcm5tVU5kcW1MWU1WTU55Mk1m?=
 =?utf-8?B?NDYvT0ltQU5RRDhna216MGlleWlzTjlSWnZpTDBWa1ZaV3kyeTVOa05DaStS?=
 =?utf-8?B?THFxM3gxSVVzbjQ5Y1ZtTlJjOU0vbkw5TlM2UWkraXI2aldaZHRDb2tKUFJm?=
 =?utf-8?B?dHZXRmNxU3BOZHZOQ0wzTXZYREhJSFYrbEJaZ3VJdEt1WDRxekxmcDRJSnNO?=
 =?utf-8?B?RnVWRlF0N21IOC9TOU8xZDJyams1ZlNkVitpWXY0VS9VYVBCZUxVSkphWml1?=
 =?utf-8?B?Y1BoZ1JKamtKclBGYnlCOXR4TzZJMXBuV05wd3huWFhPKzAzeUVlUFhyNUgy?=
 =?utf-8?B?WGRaQm9wL0p6TXFTQlVPMC9iUytmNWI5RUNWUkY0MGtvMjE3K3AxZU9DeWxQ?=
 =?utf-8?B?ZFc0TVhxR3ZDZzBORzZTS21CcXdldFMwVnhaenUrR0pCbk9oZksyQWR2cEEw?=
 =?utf-8?B?ckVVdWdCU3ZUUTZlRDlURUJNNWxWWEZLOS9QMCsrYks2NGd2OWFydlNESU1J?=
 =?utf-8?B?UFBiWW1HcjNVTVVBTVgwTzRQZkNxRHBGOFNxZ2o2dVA0cUxCcDBoMk1mM0ZR?=
 =?utf-8?B?WXhBVFJFRWNWbEwvcU9xRXlPWEhiSS9ROUdWU2lQOUNNcGh3SGJRV05udmFm?=
 =?utf-8?B?VGZPdXhXVjdhZ1JTUnRUdmtSTjlqNGZNeUlZS2gwZ3BTYmtKWHVwb0cxM2hw?=
 =?utf-8?B?YUhyVkZoTVZ1enZwOTNEblRISzNiWko0cGpObTczalFwZlpKSlJnY1VldnhO?=
 =?utf-8?B?TU5KTGp6Rmw4Z1RpMWZ0RjYwYXFoaG9aZHNlRks3UlBuU2QveDlXZ0Q5YzZk?=
 =?utf-8?B?S21wTTk1NjVTZWNwRXNjajZacHRlcGdkQk13V1NxUWNySUV3NE5HZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c57a53-6cf2-45d6-07e5-08dedcdd550a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:40:30.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgqsmcs+2tywuNSywUSGf28qHJaQBxIuSR/boU3IF3wdz3QIvtDeFyybeq9TT9wbPnp8Q0DwV2YQ4aCX5CT5Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999294

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

Patch 1 makes zero-size DPA reservations first-class. Since the resource
tree cannot represent an empty range, an empty decoder is backed by a
separately allocated resource. This keeps port->hdm_end, skip handling,
and in-order DPA accounting consistent. Operations requiring non-empty
capacity, including region attachment and poison queries, are guarded
appropriately.

Patch 2 adds the mock_zero_size_decoders cxl_test module parameter,
disabled by default. When enabled, it installs committed, locked,
zero-sized endpoint, switch, and host-bridge decoders under
host-bridge0.

Testing on arm64 covered enumeration of eight locked zero-sized
decoders, DPA reservation and release after those decoders, ACPI
unbind/rebind, module reload, poison handling, and rejection of
incompatible cxl_test module-parameter combinations. The core patch was
also previously validated on a Montage CXL Type 3 device.

Changelog:

v6->v7:
- Rebase onto cxl/for-7.3/cxl-type2-test.
- Patch 1 is unchanged.
- Adapt patch 2 to the refactored Type-2/Type-3 decoder initialization
  paths.
- Integrate mock_zero_size_decoders with special-topology parameter
  validation and reject its incompatible use with fail_autoassemble.

Richard Cheng (2):
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoders under hb0

 drivers/cxl/core/hdm.c       |  52 +++++++++++------
 drivers/cxl/core/mbox.c      |   3 +
 drivers/cxl/core/region.c    |  49 ++++++++++------
 drivers/cxl/cxl.h            |  10 ++++
 drivers/cxl/port.c           |   3 +
 tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
 6 files changed, 177 insertions(+), 49 deletions(-)


base-commit: 1c6b4ceafc3b994871c29340e0c1ddb0af5800e7
-- 
2.43.0

