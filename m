Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6C38A73F
	for <linux-cxl@vger.kernel.org>; Mon,  9 Feb 2026 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665231; cv=fail; b=b09aVxT8GMu2eQOoUWHpCF93P5Qhje5XQZ5tfjrjRKu/iRvL9QFg9ppp0NmDDikQ9vKCT7D18EOzEjDenaa3P2tDWAWFBsBCfAG8E1JLP0wwKFmA4lQ1VbUgfb1uThjacur6CV7UH01x4E4YlTthVodLw9L7lzpvHlVxHr8uH0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665231; c=relaxed/simple;
	bh=RgoPpSOBujFEXwszm/QuyDDxsZ9QUC+/ucNaex/1KnE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJeDW6O4ZYxcgLDelOjtMAgUHqi7xsOvMcZbCxxnJyEz64Pc+i/XD7YIE3FZq/kHhvkXu0l8FNC3Wok8cOaDBla9Bf4VWABbyGxCYAydXVdUHIdP8qS7ii37PiJjD/WCqK+tYrc5ReVNibvuu/jDF/jOGYeS8P7Pk7zC/WS9B0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIZemosh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIZemosh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770665231; x=1802201231;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RgoPpSOBujFEXwszm/QuyDDxsZ9QUC+/ucNaex/1KnE=;
  b=YIZemoshFbgtLVM6DRIxeqFwEOJteIBiPaU9lWzuRLJjcN0Ccnqk+6fQ
   Ve85MtBOjNOlTFHJIZ/+Ap7FIv18hafbL/th1EjcJPYX2v68O5qjWEqfH
   1HPt0l0aOKpaqnv27GW+HRUupg225Jjj1fqpjjfthW5i9MqwgF7wJb2dy
   CfPm9qZBdSqrPa4+OvyY/E+nX9mMHIk4CBozKvIkvXXrE9hPCBvDtucAH
   NWxgudtc1zJijOzeUKcpW1ZN36xXtFQ228IfylUZKU0YMVXDeZ/AAupcg
   yeiSrmouVVIyzAvCTy3b6faCoEgFTgG0bnArYj8w68xhsIJREyW75zceC
   A==;
X-CSE-ConnectionGUID: UpyXRUA4RBWrOuKHxBj5Ag==
X-CSE-MsgGUID: jQkGfOmjQVa21ir86g5tTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="83226485"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="83226485"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:27:11 -0800
X-CSE-ConnectionGUID: tmeMXP65TwCCcPKCNeSpTQ==
X-CSE-MsgGUID: 50g+EicAQ7O6Zg9tW+GNcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="210785512"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 11:27:11 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 11:27:10 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 11:27:10 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 11:27:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBDo17MdGphUM178A9N6+4OJA6jMIgZ5X9HEDFIDVJAinngfVvCTaXUXKbsQC7y2kSoYxarHbZcd/EPecge98xtnn9x7j6BPnDxTKmn5z9ivsij5XFTpbYGwp5ZfKhQnvSgX5eWdd59Ik3gMFA+6lRSbcQx0jVtdS5hia7lOwI3uSRhwB83r5b4qOD6TFKSmG8if2AjmUfNIERqlXYPoX6GMBCfMsPsJii/+a0mUg1L2q4N7qBBJ9NPVC9l2ZatQT/ol9EuqPmbdxfrrD8uHAkaXwRuPkMnpW1MJ6RcsQb/jBcIaMqgiiaWYxltUfogcXjMp6+CuZlF/IZAxzY4W/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIFSg1Yn1oBOINgSp1Z5ZBo9isAcynTerAenleZhMxk=;
 b=nQcEhhbVPVS+RJeUjbXpAK/0PcsBp3wKnKFcT5IAv4a9MzH+gMADYa5uAi25ZGgpM7IEifHWv6jPGbRH4tC5g46zmXYmgNunKzCIhZYBBviqK/qhLFXv9tWH/qLGoHHbLjMynswclFxmNmzvfXrl3JaI0erhk47rJ2j2gfIiwxPXhQwrymup5EiD4wQHAzGhJLaEm8KVfdmOVANGNFjt0xMBeASNiLQjf+KVHXEDCCkTdJwPwYdSgJ7V5IJ2Rw4nUj8H2Y+kT+jcL4XGNsoSKr5DJKc9I+vWvVAmZSsl9YGGYZ9F6xbxi/RNi6ZxKFWCx2F/7ARqxPgH7FstlPUlvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by IA4PR11MB9347.namprd11.prod.outlook.com
 (2603:10b6:208:565::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 19:27:09 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::1340:c8fe:cf51:9aa2%2]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 19:27:08 +0000
Date: Mon, 9 Feb 2026 13:30:32 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/2] cxl/test: Removal of nvdimm_bus_register() wrapper
 in cxl_test
Message-ID: <698a35d851097_c11ee10039@iweiny-mobl.notmuch>
References: <20260205001633.1813643-1-dave.jiang@intel.com>
 <20260205001633.1813643-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260205001633.1813643-2-dave.jiang@intel.com>
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|IA4PR11MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fa9d6b-706c-4bae-c49e-08de68113767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E0n1AGuy5kl411AWTriGFSoBbb3f9cxKh7U+7eOjNhgARyknK57z8Zb8rQGM?=
 =?us-ascii?Q?6W6jFG69TKDHDH7+SsKckHcMXZKKoPKtpk9p773FTeKTRPCblTsn63Sazrj4?=
 =?us-ascii?Q?ldjsKTpucEVi9OWCkoNmAoJHaq7Li9SmVvTfF1xHyVM8OQTx8hMVH9VXfelV?=
 =?us-ascii?Q?QL0jNmAzlVHXh78CwqwmrG0nnGSKcd3b/1kOEYdS8tmoObGnnR78CZv+0x82?=
 =?us-ascii?Q?ntKS6EN4ubG1p/KgTaOzjmpwL3cRUojltkbIjM53GY6Jz9l/26xRTnAsSs3K?=
 =?us-ascii?Q?XJMDF0oOFJ/JwmsXvyYnbOEhh27doILmaD8WDKzUdVEylN1yFP07StjNgw3Z?=
 =?us-ascii?Q?Yjl1RigGkHCQQdLdsriUYMawwu4bXG4m5oXAyiWvP+ds5SPnbZfiXVabho+S?=
 =?us-ascii?Q?9VlbT06ospAj97UzD0XT1ymNv1oSszq7s28/z+DOyOv9fS627jOLuM/ObQAE?=
 =?us-ascii?Q?p9HLkuMHXMWPt522nejzjbtXrioDChK0CpqbuL8cZsIdryC93e2QX9JQBTMS?=
 =?us-ascii?Q?R47c8zHD2NM0Q9D9ZcSOGomRmRL+yu+1hzUc4tkX1niZrOALb+jy919oh4Cg?=
 =?us-ascii?Q?g1g/7EFXnhdjn+JnW07HxN8LkF55kkLBNEU4amdckRe0w06UD4oIb13+uabK?=
 =?us-ascii?Q?HdvJCY8ng6sgJk2h+0+k0bFIjR9vKIVnp60+KeDYyWGafsN+yr9eO/xBvOZf?=
 =?us-ascii?Q?YX69W/wv9ngrk0b7BJE4YRudKEzMO/XErFyohX/GRed8YthdFue2Q66x9bEV?=
 =?us-ascii?Q?U+9eLtsbIQAT8y9lDMeTW9INNM0CpY/JIsmCk+TKKvN6BtBw7/H8LGNWfvCi?=
 =?us-ascii?Q?Wp3zxDO+pyrcFuaiFC6Xz/+e0Ku7wtP8Z8rkB+o12gCSva0IYsdTSG6HnVAo?=
 =?us-ascii?Q?XAetGI8XVKLaOg7CWbmL8H+apZCDwWkhS+97CtXOqKum299KYlE435aLHG9A?=
 =?us-ascii?Q?MTqI7SNzIBo8//57WmkEBuzu3R4HPbZnxhVrSwTQ7RXl5wNI6CgO2HMuGjxL?=
 =?us-ascii?Q?8RbLimh8C7shLWJTLkDzA1WXesuMNhGmNnNv0GnRwF4TtBfS+g+EARQwlpfh?=
 =?us-ascii?Q?jwz3Z6ECplaFe5jrt/Gvf9uH61KYLER4GpQTkDWyBjNVV2CnekdeFWAma6bJ?=
 =?us-ascii?Q?HUz41EPE0K1jxeYtab5v5O3k1riQKnVfSiXOd1MOhxFG8JxyC4R/obeZDCVx?=
 =?us-ascii?Q?CGBXn5c33qOd0p+6EIrk8Wjuqv0+rq04mXU760eaO28NQAZl2G9sNfozcTTs?=
 =?us-ascii?Q?l70NMcAX/RuO3xIN8GamObtefxzzZbaX0yU40HshzVJ5RjwziF84YsnPQ+3h?=
 =?us-ascii?Q?2RSdfugdSbbMwwq3+JlDi9x0kIDOhEtuWrEmo1y4R3P6YZVoCfq2y3mJDYMS?=
 =?us-ascii?Q?VbP9uSAXLloCBNSc++XTbISu3vKjyPBEo45e2w726LBcV73yVE4OUMZMOvYw?=
 =?us-ascii?Q?5jHecHbcKhKiJ3z+fNNSDbmLD0kb1VHnvaXalNPiYwBRlcwpduRllP80w+lC?=
 =?us-ascii?Q?OXDarRSRpKzCBh5W0Av8RhUoDomk4eO6za0GNk+pINfftvb7aS8CysXVcw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6eKri+pqfBwSkd0V8M7hegIE/0Vqg3WgUtm4sni/+rsiRt2VuuuiWSDuZ4m?=
 =?us-ascii?Q?cFworx2wPLUsSaHadbp37SvQl0350fMkBUGj1oab1HRePwSS/J9fgMjEnHSA?=
 =?us-ascii?Q?S/GqYpugD4Wh428d2Ni75TJvbIL5RMGOKOEM7lkyJqwvQ/E6MDolqDpObAPD?=
 =?us-ascii?Q?+M/qdX5CiIvFUv0oQ9U2tU/hJbWJ+wqhvCc4cKiMq2ilaax7MJzOnJJy2Vor?=
 =?us-ascii?Q?MStNXQeTLrpFgvJAXrVLejCnJUVe3VrMuT85V4TjZlwn142eFISQqS6qJOs7?=
 =?us-ascii?Q?DEgqLeobFuzQi/nVi5iQf6QSyNJp+cLcHU5U3kf7yl138ITojDQ0VdC4Zx9C?=
 =?us-ascii?Q?tqQGfVIMifzO9ItDFpcXNYw90gQ8dgxye+14yVfxJY5cBOCGm4QBP3l1RNxd?=
 =?us-ascii?Q?Q6l7e6H7yHopTVTQ6ae/4MWcdDhIP3gMIN6uo2vVZm4zXUpv5O2CC9w/1hN4?=
 =?us-ascii?Q?8J6oL9hOpEeE7pQADhaf0Q330ElgyOeI/0GHCmJlRTM4vBUlnFmfI3SosM+K?=
 =?us-ascii?Q?OPxx/aN12m8czdC6bNjYkXwZnd7/Nc+swMadp3WS/TG+R01pFr/8PI7Fwgnw?=
 =?us-ascii?Q?CxhoNTggiXjIfapzJnlmtjTeY/YmfAhH3R1BJ+cL7w/0BJ9NM1ZaMomMVYuF?=
 =?us-ascii?Q?chMlr/NOqU8EEC0f/4b8/CX85qjjotO0v10WF8WtgQOBrXFNRqbpON2CmhZ/?=
 =?us-ascii?Q?AnjlLEuh4HSJbF/3YvGCYQifz8I3yiyrkdPovimfQRnL2kA8u+e2VmNy11BK?=
 =?us-ascii?Q?XPC/z6qxgZNN+yTpIHXw7WBuVmp39HLO9Z4wbl1WVg++5MmOMWKCNtuHPt2/?=
 =?us-ascii?Q?m6yYoT58KVadP+J3YJ+8vKTuKCW30C1xVZD6vcKTU6Y3SFg2Ao600fnnnkgh?=
 =?us-ascii?Q?/2t4gCXmRNQPcrx3oHB7++xUvWDCl2ildMquLc/x/DBNRRF7TtmPlrOM+ZTA?=
 =?us-ascii?Q?YrJSRoHOYGRHu7IZ3c3w3b8fSWHb5aX6sCcqHxcwgn5h8SHyD7Chunz3M5HL?=
 =?us-ascii?Q?8RviBYj1/VTnbdM/Ci+7p1MZYVQGLssJ4v1dup6Ipgd08LExgDfBHCfPxYYE?=
 =?us-ascii?Q?gERTBUCRQNHEwH+ZOmHzK+FflZZyKUib+iOXBoCteaD5uooWXmjw1S8MW8C6?=
 =?us-ascii?Q?p99+aMcSqbv6eHADAiybqwJFa5at4S4bFUjVHbBgpUaYcjibnH1xU++zG26D?=
 =?us-ascii?Q?V7xkW4LJw08gRRkcqeKVM2aTIWj4HXTbBkattCoMSXjcjPzeWCBwDllzujYw?=
 =?us-ascii?Q?5ZO3mKx0uxW5vJHs8Y1si1zfyfzFV+0NDbKi9abHlUP6j84eXIFqkwftE78c?=
 =?us-ascii?Q?bPgT0oCERIp/nVTW1ZKQ6GtEgafuPGoPebaNfcwCgaIzWQtCgnJQ7Dmrdy5A?=
 =?us-ascii?Q?EPSTO698Ms8zf0s/kVvMrcPeNozpR51vF1p89CixPDm7Nm2GP6RsCT1oyhAa?=
 =?us-ascii?Q?bEcLdzp1WN25FZUozdwEeBpdqOCzZ50abt9b38Z+4siJYNUk9ouWaXNBHfsH?=
 =?us-ascii?Q?VDLhN2qfRDyzV3ia3ci3W65bLmsxPUT0qlVQRzDof67gf2WK+FR5ctW8+QRW?=
 =?us-ascii?Q?Y8g9pV9Oq8NqA2SkG8K8RDAv2HUUZqcAFY4QPjjv8fSeP36/KshGUjfhBt/E?=
 =?us-ascii?Q?VGXYIVzwgR7D+7xaDOA5X6uxZlbq7bXRjeHUOga2j+YUP115ywuC5RBLizFB?=
 =?us-ascii?Q?576GJIExhQjuNLyKv67oPdzgS7G/Y7yt/UriUkT4rnQdr6lhMVuTpY0DE9pt?=
 =?us-ascii?Q?cvksKyUaLw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fa9d6b-706c-4bae-c49e-08de68113767
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 19:27:08.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YQZJuFnbL1gaD+PZDAdv01euxGvdMjLG3eB1EIC3+pRtrBXv9pK/2IHS/wFsh0RqlHnswwq9YmE6D212dFMYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9347
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Remove nvdimm_bus_register() wrapper in cxl_test driver in order to
> address a fix in a different commit that fixes the issue of missing
> nvdimm bus object due to an initialization race. The CXL CLI unit
> test cxl-security.sh will be adjusted with this new change.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/pmem.c            |  2 +-
>  include/linux/libnvdimm.h     |  2 +-

For the nvdimm bit
Acked-by: Ira Weiny <ira.weiny@intel.com>

[snip]
