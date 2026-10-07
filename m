Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD904854F4;
	Wed,  7 Oct 2026 09:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363984; cv=fail; b=WbjsD4l/RN7AEC9xnh6940HtIdU5i6/0ZMMYDqBjax4J39DYc1B0QL0kS4wrmGN7vdgoKHhYn6mMjyAgJr8WD1Yr+pnjMurnPPy2VYl4dKP166IxLGXrT2ANkTuMCyoNzIC1a5xR7hIv8HlS8z+en4TOmy4n0YgZVtZN9ALau8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363984; c=relaxed/simple;
	bh=MqSu3tJ0Todx+ETSTKV1iqn8CZcr3T+euoV0mmaMXnA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VIhG+h4o3glD33J1zs95/z06YXgC/bZK1jSVW6Sx+OTKPy/VoJMwAb2gDTIlZXHrloD19UFQ7vqCo9PfI9q9wnjtwTPWtMjUOxw8X3sl03q/dxGGcxRXknQxJk49ysQ7phd3oYHoubnSVYekdKBdZzF2Sl6RrDe+MdxfBdCo/rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cXm46vau; arc=fail smtp.client-ip=52.101.193.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cXm46vau"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftRvSNRd3Bjllgnlzq0x10S9OmlOWXoHSRQozXrfuR7XHckdSTS5gK8iQM8h+MLE46p7Si0yrDcVMP6jvTVAB7VWSJS+uzH5EHio6JiLJyM7uxBylLO9uEGSCneU368triCj/+b7CBdq6q35/2jPcRG5xz5OD5JYycALYwbItJgAbPSmfI35wVlyVId4Dujd6ikuQXQeX7dW6eX8nEhrC7UNY+ZzWV0CSULMcSG4kIr1TKzg9csUVYXug8jYwKRtXXw+xdX36X+Ar6eRfKEpS3Oaq13p/vw1GsGIT6Gf7eQ+qsZElxe6cF8ZEuUSR5otmfle65wf5JoxE/xryr5khA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msdTojGJhULAn8luA3PtZQuFzlbh5o0qPeJ7GHNaGeo=;
 b=PVv6U/D48+dXptC+mX7Etq8Qm0F6I/BY5PMLu+NjxCHuggCX4lxipjFwqzOOYnSMH6A2v0VjRXRVK5Ggg8hoTxEygxZCoB/SIIGUKfgG61MIwFuB9TS80NT9G9sGdDeHnQJB1LsGZ6Q1NS3Bi+TfiS8cS7LXqUsj1i0cOo4yLZ25VE4NVlazHehvq5/C40Qbdy6EuRtDdLa1JeS4v6Z+Ewq1pPBcc8pQdZyJkBDkudjy786pwhs5mef6BBS+k+M6yq8lySaqpnGGHKyMrnuRngZabdnYSeQ6/uvqm0pCAxSExzq/RkF6x5yZgw+iWGFfsvhK0aziekpxWDSC9uByRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msdTojGJhULAn8luA3PtZQuFzlbh5o0qPeJ7GHNaGeo=;
 b=cXm46vau2JlDEYhIdhNg3cm5NZY8KyNbmLGK4yEIHjlfvFK/Roi7k4BtdVSZqCsjeLF/qhpokA4zVLa9diGIpx5slOriVwESK8KIAmevqfZUlgbPo2hiZ6+JHl4OIxmNlrDaz0NVU1eRrs8fqH4D7nBElTTuNMDbYFnq4p3HxW4xKLjogkeVJH7PJ6AK096pbEL31WWbc5MmmocPY7EerANeBCdJSrVWSBZ1csC1vA909Nm/EF1fVIjW6zmasRb/am7bck/g3S7QhqyuMtuSIxJDFGRsCw4ubX9a10MKd2IAQGci9+yE3EBf1qoGTBzPo7CP42ELjiunPvwiSQw5cQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:05:48 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 09:05:47 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com,
	icheng@nvidia.com
Cc: kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] cxl: Provide explicit RAM region creation for Type-2 providers
Date: Wed,  7 Oct 2026 17:05:36 +0800
Message-ID: <20261007090540.43817-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: c9586f33-4cfc-447a-33c9-08df24522d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mme9KpmHNRnAOShAX+0+Z3R4g80NwoPmtW298CRslvtS6kSPoIfetn99HUydBq0qIjVJp5OgYBEvFUWL9Gy14j0UlNC5OoVOC3K1R/+M2VZyy2yDdK9QAW1e9JQT8f770zVHp7WUkXcrRaV/bTDNLeUcAWHjjCV56c9bn0VJdvSaDlgrBt8R68m2XLSNrvz5q402hKvprhYTlUBKkyDhsiCo3lz2mP1+NDbxpIYSauVnaYbu9fjGQwZEgUVLBX30IhxiztBA0Eh/EskaKZ7pFD6VREYOKf/eZ5lONkOKOzL51gZJgwWzsTx7at+SK42A5+eYvZuDKqsj1p+Lgpcnk0XwydXu2uZ0fQ9Q+FoTEvgQzMjJDqY1x1kKmdW9tDbi7QcAPOmJTB/jpV+F1gdfnaug5ud3o71ubZiD6fUHLdVTTXT0ufCgIvnvdHgor4cyxvfWvYMM9tVpfWcsWGAyKhPPvb0AqCKkrIxG1HiklArFkcYoPgFFGDNtQvtygymyxYKDe30/dZ6ysz/8PP34saaAzfXWHnNZqoFSO2FMjZUIEo31l9zlO/Z+okSK9crvgLyeUVnH6/rw4WP+fbQcJqkm4ua/GHrZPrwvMHho2BQjJ01p0J5tSnLCokvQ22VpnVQilqy/Dh1LEAcjyZ53c597FBIfDHXzsFQvBWXIIGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cG4GN4JCSJNLjQTfmUAr+4lvYs8ENFhkRlZHGZg9lvgJMA8O50TGocZOvLpb?=
 =?us-ascii?Q?ocyjEQuWQW5OxeZbuSdpxpefDcluEHm5Fejzp/dDHyN6XxC4ExN2rEkhHoM4?=
 =?us-ascii?Q?GzwxtGb/B2lcpAFDQ0t9l7k20U08Z4/g1iM/BSZh5HFTPXuorND6U0VOWmK9?=
 =?us-ascii?Q?6s0hSpfRXdx7u2FWfzkrgmeUbhnMQFSs74BtDOj6mJIPm2eOwWhqMAqP/E7J?=
 =?us-ascii?Q?2gW37ItBI9RxglGwfnPNT8cjbLyikg3LDnrnogj1P42pr6gyha4k8RQTHsp3?=
 =?us-ascii?Q?mi6RXX6+qlidcwHiITMFSiuXokxDlFLF5Ao5x4nKpT3zF9nJwTr8JtpispES?=
 =?us-ascii?Q?FvC/bKld8xDqDZCdEd/fEDrtlBsU50/SSgk47aoZq33Kqif6R59LaULcUU49?=
 =?us-ascii?Q?HOy5kFsoqM5rZLBWywfuVvClpcYQjp4TVnauki9uoPAd3lfCsGVpOjb3NgKC?=
 =?us-ascii?Q?dq2mAfVyCgzyKhA/cGb799l343OKqTa22thQiOnNvQejSpmsBGMDYn6Ri9Si?=
 =?us-ascii?Q?q+KihA6zI5GJe07ivbAImVG1sEDJPM3IOk1RcV55K4eXSqq5DZ6VT2n87HTj?=
 =?us-ascii?Q?+UftiV+myNP2BapufOeXOtcDPnvmC4h/kn4KX53ak41OZ27HD0LNzbmoBOVN?=
 =?us-ascii?Q?O6NaePu/UQwxtgy4LH6EWp7VYmstsEhrcVUGMYE61ZZw/0rVv9MQT2HIE2ew?=
 =?us-ascii?Q?vAnt5UOpbq1fM12BkgIt3O0WahStqHR3++JjlTE7vCDd/6lkcVY014UCHCqD?=
 =?us-ascii?Q?soSFw9bFkK3b0aWlr0T3e6Xsq27A6Yg2JYeOq3Ov+c9K7cyf7uiNj6fqgWD1?=
 =?us-ascii?Q?tLR8PQqTooyTW7KraTDW9YabNhugRGTAM3oJy+3p2t9zlhZhhfZHArVsMxn/?=
 =?us-ascii?Q?r8bHiVZyApHgKnL3m35o7d7vgKKVknWZYFb6i/uyN/nqBPr9qgZDQ8TUD5eX?=
 =?us-ascii?Q?9/OcPr1TbpVdMZGPbVQkSRXMN1FqDdAcduKMnTBwT3JHg93ER2KbMLPKZ6PF?=
 =?us-ascii?Q?GA+opOFg7CqzXk5ke0BzGjFjmroMQbTxGQSO6SzsmD71/1OySoePFwII9nOH?=
 =?us-ascii?Q?Uw4KZsMPRuPhX/D94cu2hJediFlk8alHHNg73onA+TH1nV4jTGn582oeoQgZ?=
 =?us-ascii?Q?N2ckS1ouvE7kKZAs+sQ04jwYFxq9IIA/pMP/HNOBW3Sm/q7VMPfRKGIh1zca?=
 =?us-ascii?Q?JNF2CSy9J3d0em8Kf96ACCP5oCFFzbfPIKCxmvGoF4Is2UvNNDY5nbu2NRF7?=
 =?us-ascii?Q?Blg3tyqWP0pmM5R2ENwTeOUJdYn0I3C4DveZVn/VlwZrwsUDWjSzsQ5wMtBo?=
 =?us-ascii?Q?mryyp8hWYfCdQhU3UppIw2/9mNWD0scNi6uqvGcD3OKeSvW2qCS3gZ1w2ExB?=
 =?us-ascii?Q?CAGUcudxvwDc1K+4PLRi829TlLBGsRvKLpP4XfbZXsyn7YKrMb9DKzYQ4NRY?=
 =?us-ascii?Q?gxsXYTeRnaifWaeVYFnKmcJ/F1k3dqu3ZDwvzt1+2kWVPMoBw5FEO4Xo8cTE?=
 =?us-ascii?Q?iY2bU+KiAQMe06Au9fhmZv9igdlIxMFo0tulWyIY+dfej6Al4KPOqPd80ufA?=
 =?us-ascii?Q?gIGgrZvXKeZxKwjCS0JLESvcjRX8gtQrfn1zi5KWQJ4ZcjZEbTt7jJ1KcsE5?=
 =?us-ascii?Q?+8g2Zie6xaLZIrxErq7EtQO/iSVK9dBEq6eFV68bOsaY33mmkbp3QVuMaZTO?=
 =?us-ascii?Q?pNpPuqaRtr4Ez8/iNQRsWESCGcI7rKBzyztCqjakfZ4tESfDQl/WA1+G/7MQ?=
 =?us-ascii?Q?5vXmURAYYQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9586f33-4cfc-447a-33c9-08df24522d32
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:05:47.7774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vH5Rs9C/UZEEgpW8gqBS4gtVYa/5Ryu9oVZ5Vq2zXOmHOH3Xj1bX7bXe3Qcxu4NMZFog8tthIlbzBbO98sEzbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509

A Type-2 provider uses devm_cxl_probe_mem() to register its memdev
and obtain an HPA range. This requires an existing committed region,
so registration fails when firmware has not configured one.

Firmware may provide a suitable CFMWS window without programming a
region. Hot-added devices can have the same requirement. A provider
needs its endpoint topology established before deciding when to
create a region and how much memory to map.

V1 created a region implicitly during attachment and allocated the
device's full volatile capacity. Following the review discussion,
v2 separates registration, region creation, and attachment:

- devm_cxl_register_mem() registers a provider-owned memdev without
  requiring a committed region.
- devm_cxl_create_ram_region() explicitly creates a RAM region of
  the caller-selected size.
- devm_cxl_attach_mem_region() obtains the HPA range of an existing
  committed region.

The existing devm_cxl_probe_mem() interface retains its behavior.
Providers can attach to a firmware-configured region or explicitly
request creation after registration.

The creation helper reuses core DPA/HPA allocation, decoder setup,
and commit handling. Failures unwind the new allocations, and
managed teardown resets software-created mappings before releasing
their DPA.

This RFC supports single-target RAM regions with IW=1 and sizes
that are multiples of 256 MiB. It requires a compatible CFMWS window
and a programmable endpoint decoder. Persistent memory, normalized
addressing, and extended linear cache support are outside this
initial implementation.

The mock retains the firmware-configured accelerator on the original
API and adds an unconfigured accelerator using the new APIs. The
second accelerator requests 256 MiB from its 512 MiB capacity and
checks the returned HPA range. It is the caller of the new API in
this RFC; no real hardware provider is converted.

Changes since v1:
- Separate provider registration from region attachment.
- Replace implicit creation with an explicit, caller-sized RAM API.
- Use existing AUTO/LOCK flags instead of reset-context plumbing.
- Reset non-AUTO regions, including user-created regions under FIXED
  windows, while continuing to honor hardware decoder locks.
- Serialize creation against sysfs decoder configuration.
- Retry another compatible window on HPA exhaustion (-ERANGE).
- Use explicit locking and reference cleanup in the goto unwind path.
- Update the mock for the new APIs, partial-capacity allocation, and
  MANUAL DEVMEM preservation after failed saved-state restoration.



Best regards,
Richard Cheng

Richard Cheng (3):
  cxl/mem: Separate provider registration from region attachment
  cxl/mem: Add explicit RAM region creation for providers
  cxl/test: Exercise explicit Type-2 RAM region creation

 drivers/cxl/core/port.c        |   6 +
 drivers/cxl/core/region.c      | 367 ++++++++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h           |  29 ++-
 drivers/cxl/mem.c              | 100 ++++++++-
 include/cxl/cxl.h              |   3 +
 tools/testing/cxl/test/accel.c |  28 ++-
 tools/testing/cxl/test/cxl.c   |  47 ++++-
 7 files changed, 518 insertions(+), 62 deletions(-)


base-commit: f2e9991100c903ec2d8eb62c3a1d6e0b9c67432e
-- 
2.43.0

