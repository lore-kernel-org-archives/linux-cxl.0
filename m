Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22D18C933;
	Wed,  8 Jul 2026 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496571; cv=fail; b=NyUF+lMODPFgoBZPoooBSYPnJsLzNEDmbOTQBajVp5jN40ZQY1SRxa9KohTca0peN9/fRidVB8RCz2so20a7oQyLuOMuhHF+cJHBi9DDU9qyK0UW9lOL9J2TmIcVG7r+sVv06dcFQllq6wL0UqnImXBbMRGepNyW+PHtk/ZXmPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496571; c=relaxed/simple;
	bh=UWOAoEtfEwqQwES6fMmkZYT3MiknDMR1kCFKSDemaeU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g0WuidUFni/Y6kY6d+cBe0l9LJdeAyX8Fh6STgy2aPdE1+Dwm38oT8DUoOxL47lhhVSyUZrVBytgA7ArviWDJ1zwGMcCB+boGZCLWUfP0mUED+BlEVuq7M1kXjEGvPxjLCIQoOpfRTxhAcJstkKikF0iFlJGVfFHziPly/h3tpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mnnDBtOF; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnnDBtOF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVTj13XwQglVy8tHoLWQsYMrhUdSZxZ57xDVzdrZzGtnaoAE0WIXCQ8E8moQ5pWgN5Mgm9wZGFL14IDC/6R5jv2Q/+PVtwkaVBP8TQanSYR7/i4JyauyR7s5DcH/TVI7pv0au2yqTw154ELwzdKGc7EKDcrPwzHhtmHv/3wgKh9PDGE4URf+KIRXENDm3Nb2Odl67/tIxHKNJaNtXfWtRe632vpwQomouEUQd5IVKHtVXn//B2DE/4lj/N3Zy2hYO6wAm6g7veeGyF4NK4PHSRBDS+Gxjlpc0mswkTbJ2gqSPkvJbsAyLJ9sKle0HqEEZONfaBiw4nnUN/ZAiGDMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lw8wE/QgL6vLG99ltA7sZGB++JRO+sG1tYyxyCbPy20=;
 b=eAuBJpBdI9Frs5qkoWulZz4dzhlLCUpV7gNBdsscz0rpK5Bk4ZqcSP57lbABcuJLakRQYVUaGv+H8ry7I9OaZKthVAC1nxLUs7Xn2hvti6MvTxSdLg+Mtq0JhuHzgMvqJDS9ynXKqt8PN+8UgmBvk/xxAgsqB8WkUT/IOYDVEgfiFh0tMk/FtbdJSoIxtzQPPUCyI7aTrOMtBFMj7C7f+BbomKi9ldoDIuSQfGPaqGq6ORHuYqmzQgdPkC1fXQfAOMcqWldMqsthWcqzVh7UoaRqbv/IDY5RLFRrSHGRVbluFeVJqfIyO2Og8h4F+BhjU3pyYmqRf4brW5O4en4IcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lw8wE/QgL6vLG99ltA7sZGB++JRO+sG1tYyxyCbPy20=;
 b=mnnDBtOFalCSoP/pbkW2cd41av6IBzX8kz8KOc59LAnUGeUJa1uikWfpBqLGFqhF4rMeN3K5uGf2SL53SbJ8PTTl4s07q2lpEfSn4R7TirkwZekletRf9K0MBsqwFiEP6x7C5W1pLq/31SujhM3ScqrUm+Se5e8vOAHZ4taCFXqjf2X5uW7vQXr9Cs7WocI8r/04NksdFV1Ramb1j3sgqjFAbdFY/hSC/z9uIrSbSb2ZNxijT/R6Ud0ojN9NH+BRT7CFeNfo2eV1cWn8/56JQKr8ZAW07XEb04F2MJp90xfbKVO0BUutZHl8ORhxnNxRsOk7XBIRtYEf73jIiODxUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:42:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:42:34 +0000
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
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 0/5] cxl: Sashiko bug fixes
Date: Wed,  8 Jul 2026 15:42:23 +0800
Message-ID: <20260708074228.43654-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4595ca69-7685-49e1-c5fa-08dedcc4798f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	26Pcu7TuErkAeiVcKQJYIsCGw9lOQxia5KRLbclLQ0bkBMxUk20Onzgr3+zqolp8WYaQ5/4iT/P8cBR0qoZxhcgqid8GH43tbHH6oMtfEUojg4gZYXbJKfMWAyYRTvVAdA3ePhDJM25kZfjt49njW6qUopsHlHlpGuH/AzNdZrUdyhJTIin2QCWeMd/NMGinhD67kogHlMNQ4Fmk/F6h/OnNOovDBv6w8DgAD4lcl9NDN3SABAytusddXOCtU/4EHp/3cDTowxbtVnxPVwNH+ox/a6yvvvERWhTd0pSjLLbutJCY+B4pCfJoa/bEF5TX09K2GeGmeDsU9WfCVaOBMGDleoOaORA0/dR3PWkWR/sEBUkSILxBZMFG4B2kyDXCZ1F7CO2K+IrbeXs++gpkAMwDCON0iNTybAGyXEBbhgNBHs/bK5jui/ts+eXRwsY+Ly+Wv97KUMGkfUPQS00nYDayd655OdWkn4R8bPeC07zgcTgPQJZaL1PZvP2dKjY7PzoAtk5Qsgk09x6YBrawg2RtzVtOZqC4C37hnTQQ4VeMB35W5KEz75No94X3+VYeTRU3vJSgIhjfLZkZbIskF+TePziHj9cxoWlr3Osnetg4K6bbcq/fleT14uGgMuvxvOWjMeqvPe41feNkmvfk9Fj+uMf4JMI9HRbXHwmUJVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAPeHBOTInPcrny5xebci3VoQfu2uMXXsB60iiAu0kR0gN43SfeTC6Jsi1Kl?=
 =?us-ascii?Q?cGcwrj8yer34roW570XVd8puvzEvHDvVvp1N1EZ8fvEf/axB79i5Q/lrwwX1?=
 =?us-ascii?Q?lnOP7w65QmPKSLWYIUGZ3EeBO+Uc3dwCFjWJNalSCwrRWs5FI2nzdFayDVnp?=
 =?us-ascii?Q?POSPT3GJ6RwpufUMe73xjB54Yb4tVcQSSx2FcWZOumWccfR4QRp0dOYjGXyh?=
 =?us-ascii?Q?pxZHArWxWlGLBwaw8/iWD4yjYdMSHkgCadFUsNigKbtE5ebT+cvwhXT03OI/?=
 =?us-ascii?Q?yvMQPfSkpQSEPu0tlFASEuz4K4Bdv/P1XsBCpqBmkJWeJRqSFSQJXKoA866Q?=
 =?us-ascii?Q?KsuKjY92ZTFXShED6sat/h1EQkHhxF6wJDnMTk969jZfwSypR4wU1EPPiWUr?=
 =?us-ascii?Q?iweY8PmAmaYMdJFBUmhwCn85jhPJ123+n2/KfqM4GtxvQmr5C24t/SdXSDTH?=
 =?us-ascii?Q?u/KplvsBEiPcAco0GdDZrnzBzZ/AD6tVL5piEZ6e9YnvE2TLoDTEK6NuNsul?=
 =?us-ascii?Q?YLViBNkpg8BBqW4zwBRp3LwSyuRJYShKsATVtYk4gZWgv4cQMuZePHoRHT7r?=
 =?us-ascii?Q?9Ao1SQ8z1KgejVUPYzn1SfrWeRz3KK+ADs6G40Gv9ZGRE/cIRf30gPhNxpJx?=
 =?us-ascii?Q?UP8BTpo6oEKfx68+fwEHH46FXVcQ+qqIrqWHK9ALR00caEjS8yK55Bd325d5?=
 =?us-ascii?Q?7vx97rwGI9UNdXSKUFRYlmZPf203uWFDqv42JGtjA/RfhN1mIpWO7Zrp95XY?=
 =?us-ascii?Q?vun33qY658fOy52pk8mf2VheDY7hp0qp5Yk3Epqpk9gSBgvTXwLUgrMGB43L?=
 =?us-ascii?Q?wAWse/aZBo235pSzVnXmawMVxyg4CQaPyYjB09C6EY6c9Y6fnK6LzdOh1ka2?=
 =?us-ascii?Q?gSb8IRzBLoC0fMwEOqjeKZMlupKyjgCjKFuQiwgG82JLqMIWk2vkPvtzmy9h?=
 =?us-ascii?Q?rmY3++Qfvh7CkwZuGaztRoqOOCmTIME7eUuhPqTqq+ceK4rwG0z2JxRvRlRm?=
 =?us-ascii?Q?Hw9uzyXehv8bAH13+cd60IToY0KX5lIsDv/De2CDcCre6xFB+gOW7Coz277M?=
 =?us-ascii?Q?cGkurh69PNxtpn9zCsbPcgVZ5+Tw7N3xppfEJHr6+MjZBgASgccJIW1FOugM?=
 =?us-ascii?Q?6Flr2iu38hJHecqLz36nWin/3tJslIg1B/YbZqV/17HsFSpt2kVVWwhSGbME?=
 =?us-ascii?Q?687lXyKywxBVCvur1zHHWvduJ8g+G5aaq7oAc9q/AzATjSwWNCSLYaU1o/10?=
 =?us-ascii?Q?+deMmTgUR/ReWArKdALkq87kNqCns4Il7snf7eQdkJ2bSvfGdH8jflGra7PX?=
 =?us-ascii?Q?Fj1SkM0ih3IlbuqUKGYqzoIYcsnfLPOZTJPPJkmH4ez0lQMCVp86KWmoppRb?=
 =?us-ascii?Q?SHME7VEPy9FR3bQHRH2sd0Em7Uo6AuO/puDgI89wOiYYcvTuFO/FlBdAR3UP?=
 =?us-ascii?Q?6RJqdMYUIrWuR5XFNp4QIhJQTnIy1Hznkr4yaI/4vnQqdlbouHW4DUSFi9AX?=
 =?us-ascii?Q?L2lWJlpJFhjl4t6YxDy7NmAJHcLV3afoI6gPsG2/3IV9NCLs6K2TAaJ2jAoz?=
 =?us-ascii?Q?2opQ+iDHadL31otoMMc4sMWtdv7LRiPZaWHYm4Zs5+j9j6HoVNlNJZMRaG5u?=
 =?us-ascii?Q?gK0EwHg42FxLgE9L18kTEQcZGF+w7y11ysI4dPugus0CpNP/6la/tizY1Pde?=
 =?us-ascii?Q?w1ECgt0BE+h+0n5Dr1G9RAYgzFuCf6FmQqtymcVEtgc5PHtGuhmCUhtaa2si?=
 =?us-ascii?Q?DW0XwCLDzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4595ca69-7685-49e1-c5fa-08dedcc4798f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:42:34.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2SfrBqEO+YWcojDe3d4W7CIsR67LHyKfA/nXkdVFo/gzKFoHodfu2d72M06hJbh7T8bq1q2Fp61LVWVqo2FWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

Five independent, pre-existing bugs in the CXL core, reported by
sashiko.

Patch 1: Get/Set Feature derive each mailbox command's offset from the
starting offset plus the amount of data already transferred, then store
it in a 16-bit field. A large offset/count supplied through fwctl can
cause a later offset to exceed the representable feature extent and be
truncated by cpu_to_le16(), targeting the wrong feature data. Reject
invalid ranges up front.

Change cxl_get_feature() to return ssize_t so invalid input and mailbox
failures are reported as negative errno instead of being conflated with
a zero-byte result. Update all EDAC callers for the signed return
contract while preserving the existing fwctl RPC response behavior.

Patch 2: cxl_get_poison_unmapped() aborted its whole partition sweep on
the first fully-mapped partition, silently skipping unmapped poison in
all later partitions. Skip that partition instead.

Patch 3: the same function tolerated the -EFAULT a RAM partition returns
for Get Poison List but left it in rc, so a benign fault on the last
scanned partition surfaced as a spurious read failure. Clear rc, as
poison_by_decoder() already does.

Patch 4: the same function also ignored the ctx->offset handoff from
poison_by_decoder() and derived its scan start from the highest DPA
allocation, so the DPA of allocated-but-uncommitted decoders was never
scanned by either phase. Resume the sweep at ctx->offset.

Patch 5: cxl_get_poison_by_memdev() overwrote rc on each partition
query, so an earlier partition's failure was masked by a later success
and unscanned poison was reported as a clean list. Stop on any error
not tolerated as a RAM -EFAULT.

Changes since v2 [1]:
- Patch 1: change cxl_get_feature() to return ssize_t and propagate
  negative errno through all callers while preserving fwctl behavior
  (Dave)
- No code changes to patches 2-5

[1]:
https://lore.kernel.org/linux-cxl/20260702090849.47501-1-icheng@nvidia.com/

Richard Cheng (5):
  cxl/features: Reject feature offset that overflows 16-bit field
  cxl/region: Scan all partitions for unmapped poison
  cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
  cxl/region: Start unmapped poison scan at the committed decoder
    boundary
  cxl/memdev: Don't overwrite the error from an earlier partition poison
    query

 drivers/cxl/core/core.h     |  2 +-
 drivers/cxl/core/edac.c     | 20 +++++++++++++++-----
 drivers/cxl/core/features.c | 22 +++++++++++++++-------
 drivers/cxl/core/memdev.c   |  2 ++
 drivers/cxl/core/region.c   | 13 ++++++-------
 5 files changed, 39 insertions(+), 20 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.43.0

