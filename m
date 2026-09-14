Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885EC41B8E6;
	Mon, 14 Sep 2026 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376956; cv=fail; b=ssFPJdsEDLLRNbe6K0yc6hCWWOG7Ng7Qms0pTRZh6GIfAIaKl54UDAqyErUnljFbd4UlkM8ok3vXqFAtOoPNotzQw716GmyA110YMaJQ26QMv7FXqriUxralc74C7V06TpLs22qwFe8Uz883QBBvY0bjpG6MGMDB2sa2CQMvrng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376956; c=relaxed/simple;
	bh=/bXSFad9ukqiNeDwjlLQLvUXWEGL27ixv0yDn1eCvxE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jCz105imMQKX/xJ7Ibrwh3ZauE8CZcNfJMP5xXafAuhE9YHD9hrs1+pYqAFigKKxq/inAeP9LUoB5W4SzGXaB4sqo34E2DHOjcz2q7nByGio2TBO1wxG9Ux9hFdz1xz24+zq4A3VAz+WQDM6g255QEZFqERSwr0/+OFRPSA4dxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U6UNG2U+; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U6UNG2U+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEhV+sNiMoOqXi0J0k3QFuFWRrPgjhdprG+ojCayL8E0lhv8jSpng2zvD+kFQsZWbDL0K54wlZ0dt/wd6Zgen6RMOrkQqAeo0psDKXx0Ii6r3MHr1GGL1GBIRs5xxAT1NW79sevpD1iOjvsUipgffGYAxnJw1+WE4EU/FGvMyO4CZVnEGLWCF/CCr3lwXx0QpOtgoYMwOFWkMR/tHIcWbSWliX7nOFPtCSQyNautjOAzvz9m5sAQe6+Z6uKP+0JPPwqeoWfC7mZqYGzgmdzXQaOv+v42JyCtaL+wrUtcrCt83kb01J2YaZuuHJ3OVU37+fTpYFNYxxIuGLDRDrkfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KE+nogeahQVQpbSq82F6wFs89CQm2jnK6ck7ygLiGM=;
 b=PVqq40cLLhJiOpT8jp0AGk/bUl6yRPTVY9bCr0YsV/JNkKEZo3siOeHhi2QG7rfSs8bVv+h2FI1G/H/HdgCLy4jlx5kFr0V7kYyJWNElsw3Ssn6FVKdjzt4PbZIee0t6PQYugtET/f81iVizH2crhkzwtGz76JI0tj27o9/e+UeWZI8HyOKwwpXzqoQ4mOwjI0x916MWiJpeH/dtvGcLxg9WKyp/mGLqNP9vqHOka2hA/Sk9LFPrwboDY929nR6WfheVmyjcDhxPsw8ZGQSye7j9RuYJQvw6Zql5A5EooE95fcfcOcncgmkhZ35lWIoJec8L8cPbOeFZNllZK8Wbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KE+nogeahQVQpbSq82F6wFs89CQm2jnK6ck7ygLiGM=;
 b=U6UNG2U+qD5q6RsLRUAudijCO8amdhJZGlCjsyxg54kyLRVrfDTViGWkZhg7uztkLUbIqXLSiyfv4fC0JmkXFdl8DnzGcj6YryN0LNNd/6dNLa9JI27fzJSahVHcndQeqrNw1FHUdQftS8OuXhjL2tFCc1ENfEtv0ZogXKoheZGY3m+k0pBzXSwAG2o90Fi4LFgDqm5hG14RwGC8R3pKw/LXDFT3oTgyn8FquW1ilFEbHapexV5A3iUPym4Dh+zGYnuYRElgB4NIA9XBZLTJDK2jMiyQGq/sTUfZmsRzQmC33b0O1U36w9CL9W9dvttvn5mh2NtblfICyK/f1HquYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:09:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:09:05 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	vaslot@nvidia.com,
	newtonl@nvidia.com,
	mochs@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v10 0/3] Support zero-sized HDM decoders
Date: Mon, 14 Sep 2026 17:08:55 +0800
Message-ID: <20260914090858.19181-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:d10:32::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d03ad3b-f777-4a00-0fe1-08df123fd393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|18002099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	PoCSawH3g8PKe10GdsjyBM+DScAgrintJ8ezLcMnAu0SmiLz7fHeJkWYDR00jhibZASYnbkc9BJVJt0Tle37ARfaGslhuRBtlLVU0oL5XvBdDmN9mCs98tbASRZWFooaIzjw1VlVdtA/L92oV2Mp0jA6ndUiL6yoTagBRlc5J+Wi4PxzJp9a75o696JXFvmAgkqfEapAlOYbg9DrC0Dvmp4ea0lYLo6SJqlZry8W7dNglktC2SGeTZ469uLFhaCRGNiR8EfB9epnoCE+6i78EkgmCbZdgwwX9yrrU0uMko42FFkhi3OJIfPm8T8lxwNHmIzrq/s0vQIF3oKOWcTQO32xO98eqsh89ZjBOqcQMTOZ73gYhYZy/ZFy711/aoNdiWI4S2yDxIWWWI7/tEAdW3EhxNG+aOpjPg8NNHxSerXDaWzikcgeIMQe6Feoe8K7jSXFAOdc17U1H/J8yLT0HqCqBDNXeuMoQbZEvHps4p++e1NnTNevDtu4bzFmkg7wrTDXY5eVvazXrqYauq0n4aKih2AGLluRiN3zmMPLKnUgKCoxsY94akElnO1F6AbJoUTGPfK/yHeSzaIQnR0txbU4hsqTQMEZK4px34UdTwDzEI1ZKC6rHAqHcQ/J4rYYeVM4I7TvBT82ZHy/D+tQEy2R22xsz/lYaR+Z7VKkxGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDFYSWxGZUVNbGV0RVR3NkxJL0tZeWdFMitaRTNNOFgrYTIzV3hna21oQWF1?=
 =?utf-8?B?K1p4M2N6YmlEVWYwOFVJVWdiZ1F4R1huYlV6M3A4WThacDI5VzMvc1Fhdzd3?=
 =?utf-8?B?cUxuTFhGUm1XVEF4KzV6U3lqZjNnbHhNR1RCZmNpc2pLSHRESEpkaXFhbGpS?=
 =?utf-8?B?UFVyNDBQRDk3aVVsNHJjRFBQbXBXbTFPUE5oZEt4SUw2UklKN2lZVGVqOHlU?=
 =?utf-8?B?enpzaDBHckJ2MlFBRytTL2RzWFg1TVNvQjJteWt3UGR5QURhV1NhbjFNaVhR?=
 =?utf-8?B?dFBiQ3N0M2VVbHY1SXJwNFhFaG14aC9sSXVkb0h2SmZZcWZ3Q0h5eDlJK0RJ?=
 =?utf-8?B?OUFFdzhvL2I1V09PZWdoell5QlY0OGVnODU3VVgyNVFSandQaGRHaVVwalFX?=
 =?utf-8?B?U2ROL1hxVXd6NVV1TUZzZ2NaY3ZRT3oyeWlWUFBpT1BNajFMSkhUR2NDcjhj?=
 =?utf-8?B?am5iQUIrYWxHaWR0QWtxSjVmNFg3Nk1Wdkl6NVUxaVY4TW1sMFNsVTlTZTIx?=
 =?utf-8?B?WjdRM20zMk9VRlNxTG5reUF2bjRRWlpZUXd2RGlpTU9NSWF2Zng5UnZXOVNt?=
 =?utf-8?B?MVVnaHZqOTZPQjk2aXozNkdhb3JTMVVsNE9BY090V2NSN2drMUdueXF6ejRI?=
 =?utf-8?B?d1cvMWJkeWJLRlFRQmRJRWR0YldjNjRpQjU4czNVNUZDTEQ5bzVTNVFnQWpu?=
 =?utf-8?B?c0FqNEt6bkZ6NXh1aGk5bmJSNTNYUHdSeDB4N0lvU1lLcklSajkvbHNDNnZp?=
 =?utf-8?B?dnRYQVRvcE52TXZzSzhybncxMVo0dWJIQVo0cjJaYlh1Vm9mNjlMNzB5MnJm?=
 =?utf-8?B?SkRsd1FncUJQVmRhdkUrQUF6WEwrMVducHl2S3l4TGg2LzUycm5IZU9YdW50?=
 =?utf-8?B?SFJPN3ZiT3A3QWZISCt2UW9jb0NNaERsWlVEWEVvZkp5d2htNUFRejF2S2VV?=
 =?utf-8?B?SmtEWHVZVTY1Y1lQUmRkdWpxUGt3NW9jWGFXNkhnZXRXc0dKeFBFVUU1U0dI?=
 =?utf-8?B?SmowSEpWOWNsMFd4SlFYbnBiajZzQ3RwZnVFZThPSDBvSGxtOEFjWTk5VTBI?=
 =?utf-8?B?U3crWmVBeW9jSWhEejd0dFJoZEMrZmczNGxtVXRFNVh5TXErdkhnSVh6eEFI?=
 =?utf-8?B?UmZWNFBneVJjaHJpQ3FUZDRXWDZRbG1SOVc1S1Y4di9OYTVIQWJ4RExDcHZ6?=
 =?utf-8?B?TVp0Tm4zd1ZGUGJYQUpUN2tqaWs3MHc5UlJxYlJZam5sWklqWWh0ZFVhN0N4?=
 =?utf-8?B?b0hPK0pBR05nclJpaENwRDA3c0pBRTVybFlWb2E5Um5XRFNJUXNBR0RDdENk?=
 =?utf-8?B?K1RBQmJFNWhqd09pbTVzRVdKRGlNejdqcEgzT2tROUd3aFhiNWNlSXZXYnNr?=
 =?utf-8?B?MUJmSlNCdU5Xd1JEY1JLczNUcEcxVml1S0ZZREZkZE4wL3Bjb1NiVUVOWDJW?=
 =?utf-8?B?TU9QTVdzcUN1SHBzVEZZeWNuMVlDL3h6WnZwdEdQc0dIWnVDVk9kOUtaQm81?=
 =?utf-8?B?VFYwTzBPODdncjN1TFgwTWtXQ085UENrNkF5ckZFeTJxc1Z3K3B4TzRleTgy?=
 =?utf-8?B?UXhiMStCaHZTYnh1MkxtSjR1SlUzV1R4eDd5UEE5MnZPcGpNeVBJN2lEV2Vk?=
 =?utf-8?B?UWxmbUVjcjJ2TkdKN2FlVy9qU0dMbnM3OUkxc09NbDVmNnJyWnB0SXhmV1J6?=
 =?utf-8?B?Sm9aODhXU1FtayszZ3duRGROQUxHbEFjSWg1c3h2VzF5RTN5Wll5UzZtMmU0?=
 =?utf-8?B?RnljREduUVRseGV0UE9mbmErUzk1eWhrRjlMbEJBSDJUNTNVMXJ6aHpDaUNt?=
 =?utf-8?B?MlVtc3pqOFk5eUxqT2RNOVVLdUt6VTFVbnpsOHd4cjFZNzdxNXNyVmRBS1ZC?=
 =?utf-8?B?eW1tOUpJbjlBc1hKZDNWaWduN3FVL3ZSNy9LZDZDZExMNXFWNjFpTzE5Vkl0?=
 =?utf-8?B?cjVLNHZnNzlwUXNLWGVWYUxFVVA5Z3M2WVg4cHlxQ1VLZEJmYUE5OHdocG5P?=
 =?utf-8?B?TFlyNHFrQy8zZU15eDFEcmZjVmNvQUFON2hYMXlOaVg4K2NyaUZJa1JHTzBa?=
 =?utf-8?B?dHpEM0RZSmQyazduNlg0WEJjbk0vOXpIMTU5WDc1TFhLWjNWRUtXSUZrOEph?=
 =?utf-8?B?ZExZd2M2c1V6STZWTXlzYmZUcitYTDN3VCt0eFBhemJGYVNFcVJIcHZtOHpJ?=
 =?utf-8?B?MkRZWTJkV2krRU9aRGx1WkRHVWJ6U2ZhcXVIb3VmNC9ibUovL2pZVktJL3Vy?=
 =?utf-8?B?RmtLNVpuR253KzJ2SnBQOGNKZUJ2dGQxMHZjNW9abVE0Nm9vTW5GNG9BSkVl?=
 =?utf-8?B?c1AvRmpLbzg3bjkxRnYyV1AyTzRKRFVsVnZDRldYNUEzSjMrV2xaZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d03ad3b-f777-4a00-0fe1-08df123fd393
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:09:05.5477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgCnDNhN8sB3ZoVPDtLSWU5mJ2fyH+PHBhoe6IjOH1qVZGRwSsaXM+DwpB+4hQbPYdn8y6xp4uu1kbdsJ1hbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952


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

Patch 1 is a preparatory cleanup with no functional change. It clarifies
the error handling and iteration control in poison_by_decoder(), and
shares the check for a forgiven -EFAULT on a RAM partition with
cxl_get_poison_unmapped().

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

Testing:

As reported in v9, the series was tested on arm64 with cxl_test and
the ndctl v85 unit suite, with KASAN and lockdep enabled. With
mock_zero_size_decoders disabled, the full CXL suite reported 15 tests
passed and 1 skipped.

cxl-poison.sh was skipped because its unaligned translation section
was unreachable; both run_poison_test() rounds passed. Details:
https://lore.kernel.org/linux-cxl/anKpY6Y1Sqne1f7Y@MWDK4CY14F/

The core patch was also previously validated on a Montage CXL Type 3
device.

The corresponding ndctl test:
https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/

Runtime-tested v10 on a CXL Type 3 device and confirmed that normal
device operation continues to work with the series applied.

Changelog:

v9->v10 (Alison Schofield):
- Patch 2: propagate -ENOMEM when allocation of the standalone
  zero-sized resource fails.
- Patch 2: retain the original !cxled->dpa_res guard in cxl_dpa_free().
  An existing zero-sized reservation must reach the region,
  enabled-state, and release-order checks.
- Patch 2: update the commit message.
- Patches 1 and 3 are unchanged.

Previous version:
https://lore.kernel.org/linux-cxl/20260805055524.22311-1-icheng@nvidia.com/


Richard Cheng (3):
  cxl/region: Simplify poison_by_decoder() error handling
  cxl/hdm: Allow zero sized HDM decoders
  tools/testing/cxl: Enable zero sized decoders under hb0

 drivers/cxl/core/hdm.c       |  58 +++++++++++++------
 drivers/cxl/core/mbox.c      |   3 +
 drivers/cxl/core/region.c    |  69 ++++++++++++++--------
 drivers/cxl/cxl.h            |  10 ++++
 drivers/cxl/port.c           |   3 +
 tools/testing/cxl/test/cxl.c | 109 ++++++++++++++++++++++++++++++-----
 6 files changed, 195 insertions(+), 57 deletions(-)


base-commit: 899648a2707d0405f573dfc7fe15385d9ba3af55
-- 
2.43.0

