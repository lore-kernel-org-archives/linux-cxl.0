Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CAD1474B3
	for <linux-cxl@vger.kernel.org>; Wed, 24 Apr 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989069; cv=fail; b=KvJWMa+yNuNJlbxj/jIBEURR6r0IcLw40AcF1Ep7xqa2enD9BY5wa0/ako7EsUK1kxPMto0eLaUvtdy77wn38TkNTWbSwVRiwprZOiBgcLBKLwJTHiCfBBAElaC92g5tcO2Bo2SdNBnVSnLcxavdwotTffU6NW46sQYyjofrpJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989069; c=relaxed/simple;
	bh=BSjVtaO9NBh+Y7TbtFAKyzXM/xn9MGFLTeiMzP4i7A0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=h53HO+0P7XwYr0lA90sJ32DE6JmqxDl7lFk4HKRmf3FYC5LDjF/alHOymLJZPx1RZgZCctmvHUiA1mhHdcUZjiAXPjQC6xGMg3+iuft0I0rfoGgoQPcMtKZ+R8X5ICmnaT7CVQTYch5dhfE9NhdnlTyHoOo9u/Ieh1GM0dpIujs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=C15kOMU8; arc=fail smtp.client-ip=40.107.223.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="C15kOMU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzaKrVShoWwRk/piSjIDYiyBdycKrUlG0Qx8b9I6CKBB0XW+s75ss6v1FcMCFd5RGG0jCMw8Sy8ugqXsLtz2RrWeYYBJCn/uIybmdLjbtDoAFK/QaOxKCa8iqPx7bJMAoxC820aHRlUTmQyZ/B2H25qAOljvSaH9MJYq+0CMs3OwE1+sOwmGMQ6N/JH0myU1irczdOI3mVErCJPK9N6CoRWLEjruseFBSofGpx2v2MTfH/qGX186UxkYHqSqsmfdOG2QQrVRidmDPQxG6TyNFhy6aMy6ZIzgk/leB9VIB0W3ZqWVRY+vZacGt8mMpL6dAisXwsDBYNrtZZfVoxzaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wx7TUQpgXn2svQwcZic5gTntpFzkqSKnIrikoW7iQf0=;
 b=TQFqYZxdD1/m3GisOqfdRsWO/C6AkgUWPevVWK4F5VD3yedS/PmtUKAy4iB8yO5wtxAXtcwo2ErV4lwSD4OiyOmI3B/WXHsxuf4VlbtBImyjWyxp5azgyFYcxfXWu9ulbSKfKpYL3WJv273ic7f+3dB4Dn97kHAmlXZkEA2TRppt2GfPVqBJwfS7Da12ONnXBZF69+W/PvmHyzAdO5zKk76Y/ol18L56NwHpDyT6MJVR9jMPMRWp5QnaabZEMJAR2+XEeEUmOd4M1soxphxG2woxfTHW7LyHer3HfvJlW48F2YLWCSnKgD+cc/kZf+8Dfr+W1w4OkoTlP92HJCfgcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wx7TUQpgXn2svQwcZic5gTntpFzkqSKnIrikoW7iQf0=;
 b=C15kOMU864/ugcsT6bTaLll4b2OdivzcZKb3gEgJSwhWzzA9uMUv9xIH8im2m3VrMGV2b0aPzzZl+dUjxnv/dbTfDf1MYvaGd2md3CyQA+mRN878tZjZI5xs7kxznszuB2UyVOCIe5/kD+lVBd24IytyfkqbYaRpRnkKN7AcX/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from IA0PR17MB6347.namprd17.prod.outlook.com (2603:10b6:208:435::22)
 by SN4PR17MB5846.namprd17.prod.outlook.com (2603:10b6:806:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 20:04:24 +0000
Received: from IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a]) by IA0PR17MB6347.namprd17.prod.outlook.com
 ([fe80::200e:df84:29a9:8c9a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 20:04:24 +0000
From: Svetly Todorov <svetly.todorov@memverge.com>
Subject: [PATCH RFC v2 0/3] cxl: Multi-headed Single Logical Device (MHSLD)
Date: Wed, 24 Apr 2024 13:04:05 -0700
Message-Id: <20240424-cxl-2024-04-22-pullahead-v2-0-a87fc4597795@memverge.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALVlKWYC/x3MMQqAMAxA0atIZgM1FEGvIg7FpBooKi1KoXh3q
 +Mb/i+QJKokGJsCUW5NeuwV1DawbG5fBZWrgQxZY4lwyQE/oLFYeV4huE0co+fe8yA9d0JQ8zO
 K1/yvp/l5XgKMHEZqAAAA
To: qemu-devel@nongnu.org
Cc: Svetly Todorov <svetly.todorov@memverge.com>, 
 Gregory Price <gregory.price@memverge.com>, jonathan.cameron@huawei.com, 
 linux-cxl@vger.kernel.org, nifan.cxl@gmail.com
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713989063; l=4382;
 i=svetly.todorov@memverge.com; s=20240312; h=from:subject:message-id;
 bh=BSjVtaO9NBh+Y7TbtFAKyzXM/xn9MGFLTeiMzP4i7A0=;
 b=98qdpKg/Y71Z5Mi+h5s5MoT8o0e1niqL247WOx8dKwp7E9jphWkEwrdMMnYgi/F0fsjdZa3b+
 iBrxmo5rAhrBpniE42bt1J7SxFhiiQmj3OndxdbBRMcWf5J7iSSaTbo
X-Developer-Key: i=svetly.todorov@memverge.com; a=ed25519;
 pk=bo0spdkY5tAEf+QP9ZH+jA9biE/razmOR7VcBXnymUE=
X-ClientProxiedBy: BY3PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::10) To IA0PR17MB6347.namprd17.prod.outlook.com
 (2603:10b6:208:435::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR17MB6347:EE_|SN4PR17MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0fb8be-ae44-4a30-b752-08dc6499bcb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEcwY2xtR0d0SEwyQUgvMDBPQlRJSmFaNDFDdlA3eStnd3JCZFhrVUFIRzdI?=
 =?utf-8?B?aHFmSUZzQWNLaVRrWXRqVkpLVkF4Y3lGTWRNeU9xQzgydUNYUmdSQzdHMzQr?=
 =?utf-8?B?RURFYi9uTnZkY0FZS1pxMzRjelNPemx6RkNpMm9lQWEwQ1RGUnNRRkJBS1Uz?=
 =?utf-8?B?NENlajd6aDhjRnFFVE5MSUpUdE1iOWxzN3pEOExxcVNPWWhGdUhrL2NIUWE5?=
 =?utf-8?B?TVhFR2liUlNQdGVReUVRUTF2VUZVRENrcVlxYThyVEJHWVAvcG51YlY0RzBi?=
 =?utf-8?B?SFVVY3FDeFI5UkhETTh3SHFoTTBGaGdNY0VoRWlBYitaREprdWxSUCt2ZU1m?=
 =?utf-8?B?MFJmL0xqTFd5azFrQ3VyZE83UmlPbTRyazQyZXk3dVRkQXFZbHVVckVRVVIr?=
 =?utf-8?B?aS9nVEZCR0E4bEVXL2lGNFpBRUk4a0I2c1pNZWtjSGNsWGI4MnY5UFl2eXVB?=
 =?utf-8?B?REV1ZG80ODlqQ1VLaHZZSGZ3eVdHUG9OQ2hkbG5nR2s5ZFFWU2FPOGFFVk5J?=
 =?utf-8?B?ZldRK1lNWFVJR0kyajBHLy96Ukp5bnpWT3Nkb21PdElwZXRSNkhzM3ZZM0Vk?=
 =?utf-8?B?VjNjeTRTczUvWG9paTdpWDhIWEdyTlpDKzRpMWEzd3ZDTno1Tjl5L1BCZVZq?=
 =?utf-8?B?citxSE9RNXAwdjYwTDhubStvbzlWZjF6aXJMMEh6bXUzYytwbXg3bW9SOVZ2?=
 =?utf-8?B?SlIybkR1WnBkMHJETTFSVnpOb2dSaUhWTDZlK3JnRXlEYkFVNnA1UmpKd1lY?=
 =?utf-8?B?bUJMdjZUZnFXVDRhbzFuakc2emtkY3hucGxBMU5Qb0x0blBNTmZNL1FTR3Fx?=
 =?utf-8?B?S051MGJjSVlyNFlqSDVZNnR5aGxhSEtyVXl3dVFIdWg0VXc0dy9ScmhuY2gz?=
 =?utf-8?B?b21nUDBUcHdrTE5iRFBVOTRjaHVsQy9DWHA0bTh5L3F0M3RBWElHVjh2YStQ?=
 =?utf-8?B?UUlwZzV3dGFaU2tQMVJucVp5azVzMHZWM3RNSGxrYnFRZHlSbEQwcGpmajhS?=
 =?utf-8?B?M2Nqczc5SnB2YzRYejk0OWU2VHN0Rkg5SExkWFpEdzdpRW9jcHUvbHhPYVdS?=
 =?utf-8?B?Tk5xajlqR3QzM0pjbzRPb3V0SG5HTTBUL1lSVFBuRytuYmE4WTBSL0kvMkhu?=
 =?utf-8?B?WjJTZ3pMZnR1b0VMUUQzZmZDaW0xbU0vWllubHJaaUw2a1hnNGw4R2JlK29h?=
 =?utf-8?B?cUtRK1o4OU8vazhYVmNOZVRpa0M1WWJOM2JaaE1CU1dWWEYzU0lPcW54ZjEr?=
 =?utf-8?B?NVd6aWp1ZkxxeGY5cGlsa3N4WUFabmJzY3dSeFZVemlWYUErV3JwbGxKcEM5?=
 =?utf-8?B?RHc1WVQ3SVNleWtteU1TbldmQ3BOb0FpczNXaG5KQm5wUk9FeEpUYWwyZ3ln?=
 =?utf-8?B?eUhCUElReURxUmJwWG02aWNDSTJLQlQ1eFdhc1IrcnE1UFIxK3BiOVFWSm5y?=
 =?utf-8?B?SkF3dVAyZHBUY1pZblVNclFVM0luclBWcFI4UFlTcUorbGtTODlEWHdnUkUy?=
 =?utf-8?B?Mk9ESjliek91cUZOU0JrbkV3aHpSUHZFcGtMbkZwVzdITEsxWXBVYlZCMDls?=
 =?utf-8?B?bXdOYk5LV0FPTktmSUhsUkkyOXkrT2hlSFVSTzJFYkswR3pnbDVFUXh5Vncv?=
 =?utf-8?B?d3dOT1ZYN2hLRDNqbE9yNy9ZWTIxOFlaNUhDeEdRUHFyVlBhditIdFR5d3VG?=
 =?utf-8?B?UEY2bFovSDZiTWdjMVdjdUxRWSt2NTliU0MrN0FkbVJPVWNDNFlaMWJmSExH?=
 =?utf-8?B?S0xGL1RlZFhFcloyN2RiOGFaK3FVWExrTlg2eXhRcVdic1hEVEVUdnNsQlhM?=
 =?utf-8?B?elhPWDNIMUFmTE0zVXpnZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6347.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWEwYmZQQ2JqM0FlbzJZT0pxR1VnRWIzZ2JzSWFMN2duby9pb0xGY240OEM0?=
 =?utf-8?B?Vm5zc2thaU9lKzFyRG15RGpVcUx1WWdmTTBuWklSUW5UQUh4MGhrelRUOVFH?=
 =?utf-8?B?eDFtVmF4Q0NiRkVoWUJJa1F3dmpiaDYxdElxWDQwTUt5NlZ4THVqa3k1VGli?=
 =?utf-8?B?K2xwREhaK2tha25aWTdYY2pxZXpaYVAvR2twMUtEMXBncE9MdnNVWE42RWU4?=
 =?utf-8?B?WDVBdHpncnZ0TDRZRnJoQ241K3paYXZ1c2lRUHVrWVo5Wk41QXkyUEhpUVli?=
 =?utf-8?B?M0lILzF5ZklGc0paSXJ2L2FsNzJGQll0NVFDWVYrN0JFT2hBekFOelhaU1VE?=
 =?utf-8?B?WnByb2tCa1Q0SFJhVFhXRktqYzJJRHRHNVphQXdxb2ozYllQYkZ6Y2tieWwx?=
 =?utf-8?B?UzlKT2hiQU1mV3g5T0xRWTdQQ3JZU0t5bnpJd1VTNDR6MkluVkQwNjJqM0VI?=
 =?utf-8?B?Zzd2Z3Z0b2dBWVFBU1Jwa2F5cGV6dTlVeWNzNlJHZ1c0cFlraGZiNVJ0alVX?=
 =?utf-8?B?UEluWHVzYXdLYjduWDAreWx6ZVJ0MmxMWGVxakFtQVMxYldSZ09vUFJDMjJj?=
 =?utf-8?B?amp6VTlCYitWWnoyTzUyUkQvTnI5ajBZVXNHblRsL2FoNDlUNDlwNjlBRy8w?=
 =?utf-8?B?ZGtwUE5uRnV3d3pnTEdDbGcxWHkzQVlHZGpVb3JaMS9RS1JGd1VVM0c1dXpT?=
 =?utf-8?B?NmdNcnI1UStESjJOZ01ZNEVJendNZzRKcHQ2RitjaEI2NC9Ydmh0SFkwV1VO?=
 =?utf-8?B?djBqamVVZjlvMVVxb2ZuLzhUVC9FK1Z0TnV6VzhzR1d3ejRNNlJPeEs5dHJN?=
 =?utf-8?B?VWIxMHR1V1I5L1A2VW9PTitJblJCTkpoME80Q3RhZmk4UC9DT1BNNjJqcS8y?=
 =?utf-8?B?STNVOHFiaEtwcDRGMU1QdjNSSUF6UTR0ZGlkTm1RWitxSjdudkllZVVpZ1Ux?=
 =?utf-8?B?TmlobGszMHNxV3JEbXhyQ2pFdFFWUUVaM2dYMFF6TmVyMEFJVnJMSTI5c0VE?=
 =?utf-8?B?ZWp3UlpGSUtjRFpVeWxoU25xNmJ5ZGpBRzdSR3VqOXFaSGVlWHJVUXIzaXZG?=
 =?utf-8?B?WGxPU2IrZEhrSjlSblVxbm12dHdhNHkwWi9YbTVZUEhGMVdEdlJuSmJYZnUz?=
 =?utf-8?B?NGhqU2hxM2cwa1NDWDhadVlDU1NrZ1oxY1I4TGV5cU43b09LSUFMRHZFYS9E?=
 =?utf-8?B?WEpIQjNFOG1tY2pEdWR3UkppWjkyQjlLZjNOWWYzUmxGaTRFaVJydytlL2pF?=
 =?utf-8?B?M0tjR1hhZ0Y2TFpiQ1d4RGJkS21nZU5sRWovT0g0dGhmNzRXQlUvM3NvQlVa?=
 =?utf-8?B?aXlyVXB4TnhYM3NrcWZVZGUraCtBSkpKdndqNjFBSGg2em1ybTJ6NFFDcUZV?=
 =?utf-8?B?T3JmZWI4Q2ZQSFBYQ2JNd1BqbVhiVjEyekpHQnNuSlc3ZEIwRW9TV2l3a1l3?=
 =?utf-8?B?WFo1MWVkaVZoNkpzQkVtb2MwS0JIVUo1UG5iRWdiZmxmb2JxaUpWTjc5aUcz?=
 =?utf-8?B?TUJOVWc4QXdEL2ZRdDVvVVNBdDVLM3lZalExWTYrdVA1Q3ZuUldMUzdlQjlC?=
 =?utf-8?B?YUNzbnN4MFhnNFdTTWRmYkwvc3NrMUZFZVd2bGtIaitpVXZtVjF5Ykg5MkVL?=
 =?utf-8?B?bXhiUHF6YW4zWnNyU2Q5VGMzT3lmZGsyV2dMTHhZQXUzRjdiTWdwYnBLQkpS?=
 =?utf-8?B?dG9ycEUrTXJiWlBnV3JGUzl4QUgyVjg4NmgzSlM5dWVqdjVOY0lXMGhQMS9O?=
 =?utf-8?B?anIwOCthVm5GMDBiUUNVYURJQ3hodXVLVjRyWXlhcVBNenVqL3QzcFBxVmVs?=
 =?utf-8?B?YUs0bzgyK1greWNsVjg3Wm5aWUNIRWExYkRmbytBa2QvOGlobTdjbkw2aHda?=
 =?utf-8?B?MzN6VGNuZC9yQlVzSUU2QVROYjN4TkxMUXNNWEp0MFVwSzVXR3I1YW9ieG1O?=
 =?utf-8?B?WlAyVUwzYjEzK2FKdlM5ZmxTTXlhS0MvdDR3UWI2K1pNWTdqdW54VElHa2Rh?=
 =?utf-8?B?dHlaL3l4eitzK21rV3A2NDFzR1BiMFE4ZjZ4OTA1NHd4V0MzUGpFZ1pGQWxj?=
 =?utf-8?B?dXIwM0hGczZndEpYMnJBSmFsdmhrU09IY21OVS9WQ0FUSnFvZTBUeVdkUWtU?=
 =?utf-8?B?dVpjb0QyY1czaUd6emNuYnkyMzZrczRVY3pHOTBLU3JIbTZvOHlaRWtkbEQ5?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0fb8be-ae44-4a30-b752-08dc6499bcb7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6347.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 20:04:23.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSKfE3EHSU148TPgvtxUYlbY1/zlQgunJsqmke0u9xomW2JPWXYCw92DsiL1dqm07fJ/4BTUUcDQ2/2vVFy1NbEHPGVZFH5bw6VtlD0nzlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR17MB5846

MHSLDs allow multiple hosts to access dynamic capacity on a single
backing device. This complicates DC management because adds,
removals, and accesses need to be vetted such that hosts don't
stomp on each other's data.

This patchset proposes a set of hooks to be called in cxl_type3.c
when each of the above events happens. The results of the hooks
can be used to prevent illegal DC operations in the corresponding
cxl_* functions. 

It also proposes an implementation for MHSLD emulation. The device's
state is stored in a shared memory-backed file (on Linux, under /dev/shm).
Extent ownership is tracked in a bytemap, wherein every byte acts
as a set of flags showing which host ID can access the extent at that
index. Blocks in an extent are claimed via compare-and-swap. Failure to
claim the entirety of an extent is treated as a failure; the host will
parse back over any blocks claimed so far and mask out its corresponding
ownership bit. Operations on block states are done via atomics. This
allows claims on unrelated extents to be serviced concurrently.

Block state is relegated to a u8 to conserve space.
Therefore only 8 heads are currently supported.

The MHSLD device inherits from the CXL_TYPE3 class and adds the following
configuration options:
--mhd-head=<u32>
--mhd-state_file=<str>
--mhd-init=<bool>

--mhd-head specifies the head ID of the host on the given device.

--mhd-state_file is the name of the shared-memory-backed file used
to store the MHD state.

--mhd-init indicates whether this QEMU instance should initialize
the state_file; if so, the instance will create the file if it does
not exist, ftruncate it to the appropriate size, and initialize its
header. It is assumed that the --mhd-init instance is run and allowed
to completely finish configuration before any other guests access the
shared state.

The shared state file only needs to be intialized once. Even if a guest
dies without clearing the ownership bits associated with its head-ID,
future guests with that ID will clear those bits in cxl_mhsld_realize(),
regardless of whether mhd_init is true or false.

The following command line options create an MHSLD with 4GB of
backing memory, whose state is tracked in /dev/shm/mhd_metadata.
--mhd-init=true tells this instance to initialize the file as
described above.

./qemu-system_x86-64 \
[... other options ...] \
-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
-object memory-backend-ram,id=mem0,size=4G \
-device cxl-mhsld,bus=rp0,num-dc-regions=1,volatile-dc-memdev=mem0,id=cxl-mem0,sn=66667,mhd-head=0,mhd-state_file=mhd_metadata,mhd-init=true \
-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G \
-qmp unix:/tmp/qmp-sock-1,server,nowait

Once this guest completes setup, other guests looking to access the
device can be booted with the same configuration options, but with
--mhd-head != 0,
--mhd-init=false,
and a different QMP socket.

The first patch in the series moves the CXLUpdateDCExtentListInPl
struct to a shared header. This allows DC-management code outside
of cxl_type3.c (like mhsld.c) to see which extents have been
accepted by a host in its DC-add response.

Signed-off-by: Svetly Todorov <svetly.todorov@memverge.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com

Changes in v2:
- remove explicit init_mhsld script
- implement remaining DC add/remove logic
- link to v1: https://lore.kernel.org/qemu-devel/20240308185211.277116-1-gregory.price@memverge.com/

---
Svetly Todorov (3):
      cxl-mailbox-utils: move CXLUpdateDCExtentListInPl into header
      cxl_type3: add MHD callbacks
      mhsld: implement MHSLD device

 hw/cxl/Kconfig              |   1 +
 hw/cxl/cxl-mailbox-utils.c  |  44 +++--
 hw/cxl/meson.build          |   1 +
 hw/cxl/mhsld/Kconfig        |   4 +
 hw/cxl/mhsld/meson.build    |   3 +
 hw/cxl/mhsld/mhsld.c        | 456 ++++++++++++++++++++++++++++++++++++++++++++
 hw/cxl/mhsld/mhsld.h        |  75 ++++++++
 hw/mem/cxl_type3.c          |  17 ++
 include/hw/cxl/cxl_device.h |  24 +++
 9 files changed, 608 insertions(+), 17 deletions(-)
---
base-commit: 532d3bf76f73b8edafd3333dacae449b7c9bb61d
change-id: 20240422-cxl-2024-04-22-pullahead-fd6fd9e6d1e2

Best regards,
-- 
Svetly Todorov <svetly.todorov@memverge.com>

