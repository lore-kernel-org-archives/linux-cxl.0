Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D623BB12F;
	Tue, 21 Jul 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624249; cv=fail; b=i7PdMBokWLk91Lb9yncOVdCd+VA6ESHGvJ80+fgvcpnY414UxNikk2LitHUVgFoNZyzddFlqhTXHT3i8X0z5gjVjIno+/0sKA0SK29nOkB7U22tOnspm8QuDuj2ve4xzPJMNemWfa7g+mFwYoZbUquCRmIcN46SpVCVhp8Xl68E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624249; c=relaxed/simple;
	bh=jzqkI2/P0BOs3qFuG/pyf1RvPR4kg9IAG0CUTY9/Y9k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cI3eJ7VR9A5OPRgTfStpqXYyvwKvFOf2jw4DpEJpyHucwU62BQFKkKvBXby4JAkyvscPNGJH1qSaruvPcEdyFILR6dnglKDKF7KL1qAJJ3wniypnizlYOcr1do5xcwdnvrbl9VbPfpT+SAxnfCi/i0pnrBInC44urdg0BiUB/l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m0RNKwr/; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m0RNKwr/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmQfxdyIL+PPcqyqfvw6yUSm26iZMRNrMFosTqWMaOhfdOjDDiWDJMVqnlkO6zWyLKnuYtaBjZaZQ53RuklubqemvHSREK47idEQhHZJTe2MToxr+eJgKiqxKWejN0/ieGbSGf/D8t38yxMhIsqyXLQCyfRISqGMSHBSpn72nhvU3m/lnEOz+vuSQAR3au9nJmtENETGW0zGquIx1dNGlYkKS+g4kPQjiaFvtLY9BZB0LWpK5eWjqhqE8zhkDRrCuTc6qBY7f54IB2z5DZqhaSbjgXrZL+5mg4WLtVuHhnQYMGs8duOe1jkIJhhaNtEnJSUaX9OUCKXmW0+mueDVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTIZ0LGnCZUdbP/JYtCM15Cu0issWjrrdENVvsAEXg0=;
 b=Ji67Qi3TN/0Z+SGNmVB2PjRcuOdsrl+WmQDYz7iQaFTmT7VBY+5BppWstQ0pBaVeHalGGUBJBId1XlDNpzTo9R08fvL/Ro2rUVI1oxSpQb8f+2BsPZp7FnaIuqOBc/TzvLm6vkCclKnQlqXb+IqvqQE1XuEMjOt8rLZoxhbDdbzY/stTIswEZemyXiuSuwtUk8F0gI/8eeTJz6bVPSGc3GxcPryDii0abZ3DicmFfn2pNoUP3l1p428qTgktpmSFM06V0j/1B5JtRCx4+WzFuDYY7EMt7AVvOGY+sh/IBiAgDTNc1NNuk+SdXpBmP3Enb0NV2qSJ2gKEhpi+vMQJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTIZ0LGnCZUdbP/JYtCM15Cu0issWjrrdENVvsAEXg0=;
 b=m0RNKwr/qsYakfm6bZL8tooMjF/nf6mwgObYkPtIBOIXyNkc8n84H3VjAjhdVMwAq6wgCyFzAs29hqHqnz4ehDz2TOLhqIqJ5jDvj438lz2AF3k8qCCsTfrvaGN+N4v4okLruJN0yu8lO4pYzWxxq9V2mzk3NezJskPm+jm4eGEp2sr82g+7Wqjzrnv/ayAgor4MndN5WylUSK1Dp19z4zRxROmGQsyIkA5div0yAArfbTLW8tVdDCBnAylZ8n13L1ayKsi6x2lLynhGoptmoEQdJ5gexK26+Ri1Nyyr0iF/gihUUN2QVuN22OogYpVHMm5eIKQrDVbMLakk5Jux4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 08:57:23 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:57:23 +0000
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
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v7 0/2 RESEND] Support zero-sized HDM decoders
Date: Tue, 21 Jul 2026 16:57:13 +0800
Message-ID: <20260721085715.39322-1-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0192.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::21) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e873c2-bd19-4121-b557-08dee7061428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vCLaYkZ7QiVaNV/GcM56ljfSI3Xa11t0h32HLCXJoZ7THkGHEtcimn/r9ofH2PkqaWcuIvvs0cSvCeXXNui3RYBytW175GIxB/9aqJCjYc90U47Je5KUBvP2kLfE14eXZvBoKCQlsxrfMZtsaqnup6y3cBcUi1pKdwcaP07Sg2d8ts02WmVTjriC2azelE51SFWZL/uxBozK9fxWg5PgyQa747dwVCCpojYHml+07m3NHFvGVS65RZw1gwLCF4W1AF4ZdeRlRhvv8Ie/uOXA/6SeNy8eB846BUP9ki0Rg0iWyeoK5wPSCv42YjmOx4QOhitBYic8YOSde5cQL3aN+394eR5lfrb2hATu70su4CRoXIKn/DYDLrhxgd0lyPIx0jiB8q5gpljWIyxpxGMrxP22Oh+v+05tuT1s3WqpppC8WpzA5WN6YEpqO+FoF4xU/77D4/kS8El0h6o/ziUuTe/6l2EAAx9Tnj1EzgA5dMgNNCtSiZB3I00Ha3J+cUIWEaJlynZpXRTL4rMr+qc3GnzIgBF0nVkk+Z7SdLdR9kVtwIL5n7dxnxpXnpwTYGq2S/fPVBsZBKj4nX/fdbJpflhbqMU09kxgfGwYunF4SnMjELsRU6B620HlWTRp0z3zyh7SR3zQMnW91qJABza4o0mnSqEFGNx65DOfeWPxF3s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDl2SW9Obnh0eVdsU0plSDRwOW0vOS9WRmZKRldObjNBeGZYS3V0enREVG40?=
 =?utf-8?B?TjlTb2ZuUDZEZGJPekY2TnpwTm01b0JXejlFdXU1RjZYbHBlL1phRnlDam9o?=
 =?utf-8?B?UVNEYUhNVU1TRFMvc1RhUmJRVmF0RGJtSWl6bEJrajAwUFJPZmRQY1BLZk1h?=
 =?utf-8?B?bTZPOGJ3RWZBOFljVmlDSHJTS1pERE0vMnA0UDgwc2pmSUwxdk1XUDNNdzkw?=
 =?utf-8?B?UkFISjc0a3FOV3ZvTnhFY2xnSFlQSUVOdWVrSFFGdlliRlNmUjQrdjN3cDR5?=
 =?utf-8?B?MSs5NXBJdVRCaTdEV2RsUzRzTHRTUDduQTBCcjdVYnFDbHBtYjZtTUgvTW5n?=
 =?utf-8?B?MDFIWXp1K1ZXbmJZQ2RhQmhrMCtQN1ZSSzlJVStXK1dMTHErQmsyYjVjTjNM?=
 =?utf-8?B?WmpIelpwWXFMd3ExVzZHdDF4M3hZQ3lBQVR1MThXZytqVGlOYlFBcU14ZDFy?=
 =?utf-8?B?YmdZZVdKeVNYTENSRWdVTENjUm5HZTYzcVhIMmJEYjBLaU1IUlVMVlI1MEpF?=
 =?utf-8?B?a3hhYTdyVkNiN1dMaS9jU0h6RUZLOUNhZlNOR01ReUFEVldiZlBKZFVVeHo0?=
 =?utf-8?B?c0luUVgrNFRTSXBwZEtYeTZ4ZlZZZDh1Nit3Q1F1czV5aHdGKzI5SGNqeDAy?=
 =?utf-8?B?alU1UWtXUzlrbTNsckRaMjgxZkdac2hVUzJhYVR1eDQrZEpibW1vM2JucjJQ?=
 =?utf-8?B?ZEdSQU1SdnV6YXlVSUJRaHg3d2F5QnlDbEN3UjZhaGtxdUhBTlBadnJUVVZB?=
 =?utf-8?B?Qm9wVFpiN256ODlkRnpvTXZwemZ5THZWVTlYdWZKY3RYS0p6SUllU2tLVFBF?=
 =?utf-8?B?UnN1WGw3THA3V0xqRHN2Wkd2NEdjZ0hWYm1yWi84akUxb28ybzBSOFNrU1lU?=
 =?utf-8?B?WS8rbDNFdzhlcmI3bnNpUlAxRURodzl3RSs5dWlWNFBqbzA5R21GWEx0S3JB?=
 =?utf-8?B?WWd4VkRJLzd0RWVoWkVXWVp0TWdycml6Uk90VTVjNk9zWGgydTgzeHYzWDFw?=
 =?utf-8?B?azhwOG5UR0c4dGlyeXFTVjh2c3pXQ3J0MXF5RVZvV1ByL2hnL2ZPZzVSdW04?=
 =?utf-8?B?d2l0UnZiemo4OHVxUm5VdVpYSnZTcDRJeEhURmk0dTlNMmpDWitwR3FldlNR?=
 =?utf-8?B?bExUZW9GWTh2TU00ZnJ5am5CRE11VWpidkJXd3IvalU4UHVQZngweks2QmJV?=
 =?utf-8?B?L3lUdUtmblBqUUI3TytUTnV6WXQ0RVlZY2EwSWpwM2xJRlFLcXNSN2ljN1Zv?=
 =?utf-8?B?aFhocTlmam81ZWhKYmVLYXB1SjRGV0MrZDdERFc5NGVoZElOZDJwb2RJYlFw?=
 =?utf-8?B?RjFydXdBY1kyUmt6cndUU0lnQlRsNzg3emtJQ3RBUTd6V09oR3VaV3dOQ0ky?=
 =?utf-8?B?REVuUTd0azZYNFIyT0RPSGVKRjZudUtSa09BQ2toS2NZQnlsY2hCS1Q2S05F?=
 =?utf-8?B?OTZ2SEJNNUtWK1BVQjZGWWlRc2NKRXVidjdRaDFmOTl1TVNzdzZFaTZVOUdX?=
 =?utf-8?B?THVuVXRzeFRvakcwNnB5ejlRMWRzNVpneHhKb2dEQUpwRVIvVElpL1JabUNs?=
 =?utf-8?B?d3hQVzAxTGcxcGZPZFArZThwc0pkc0N3eTZZTnZVYk0xR1I2L1AwMGF4a2tH?=
 =?utf-8?B?OWtSYWs0eUJHb0lhZm5xVUl0TElWM09ncXAvbG5tclZHQjBzMkVXdk9wakFo?=
 =?utf-8?B?ek9oaUtPZEh4OXFkZkdKQUhQV0dlZ0Z4UGk3NTNVZElBN3ZZODM3WjUyd3M4?=
 =?utf-8?B?c2dEeE5IVDhnZ0xvM2QrVmkrSEcrSjFBWVpEd0pHZm53MFkyZ2ZjUUJBdStT?=
 =?utf-8?B?aGFDZytqelBXNmVWYmNoQkg2NG1QQnNXbnpzUEFZMzdUZmhibE0rM3VBby9U?=
 =?utf-8?B?enJqZ1VkSEVOTWZjTUIvdndaWnI3dVVWSTBtSGVaYmc2TzIyZC85UFIwN3Rl?=
 =?utf-8?B?WWZIOStsMk9SZEV0d2xiQTZBS29ITlEvTjdHMVF0UFluTmMweHlqTEpEZXJM?=
 =?utf-8?B?THJSU2dyMkV1Q0tyc0w0WVpOR2UzV0FaQ2RZNGtMN0JUMm1pTkFoRzIxUzNn?=
 =?utf-8?B?SXFzUktCR3pTMmw1TlcxckhoQXhSMjNhajNpSnc2Y2xHL28zaFBYRU5NNVB2?=
 =?utf-8?B?V2V3TVBZaFlXK3lRRnI3K3U1YU5iQSthUzFVVjFidEV6cXhYZjFmeEVnekFF?=
 =?utf-8?B?alJNeG02ak1ZV1VvcDVwVDNncTV3OExvK2QrWWxMMENxM2VFUHRTNjJRQUhN?=
 =?utf-8?B?ZkthRDE4TUIzVVkvTDdxcjMvYmZCa3FxalFQb1dSK3luUGZacHVCZDhQSkxn?=
 =?utf-8?B?cklpeGdEbVEveldBSmw1Y0FwMFJETkhZdEJiUFl2NWtTWUF1VSsxdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e873c2-bd19-4121-b557-08dee7061428
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:57:23.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq8esgvX3LhBeF56bj2XMS2h8WudfKqA3PWV/y+nor21MtOo4J3MhXcDM0WvM5vviPdX+ouPfaLm8vtdGm/Ktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

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

The corresponding ndctl test is attached at
https://lore.kernel.org/linux-cxl/20260709022857.18732-1-icheng@nvidia.com/

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

