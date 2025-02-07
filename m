Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121014D43D
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 20:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958781; cv=fail; b=EqLuuXZB81ZHfU7XFaCviRMEi7PY+G0bm0cWZYPlWjcZlOBW6ve9mT60ki8jr3lMs+oo+THm8h6yMUQ2q1b5ynN12iRn/Ih9NsiHlqz19lOgggoStW81sSF5vR2nGJxCapIWA+HnxVHRhOJswT3JLKht7Uczw5O2cHbiOHJv7qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958781; c=relaxed/simple;
	bh=ZfYkDhqGqDmfOBLc8LC2mCHKU+W0UGjYho4eHeEgwOo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CcoF4Zz+ctufsxNl/Pyl5YQCVadOCqm4QnqP1uKWflEkMrmA0CAWmIzpOZBv404/FD9F5lGaqqtxSJd/eTn5/3VmI/I6E00ngjF0DQ24nQQK0c2F1ykTdjy247NHMXJ7pwajvmba3jbshdvtTB0OVMGVl1KjSLZHY5wSrkQxM40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AM8G2+Lu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AM8G2+Lu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738958780; x=1770494780;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZfYkDhqGqDmfOBLc8LC2mCHKU+W0UGjYho4eHeEgwOo=;
  b=AM8G2+Luy4LRv7yYgTJ0PpZbouoPU6kb5/BybXMk6JfKSH+YvbvHIpTK
   H88xwnbQHRu9rKVaQxfMvJ8MrWsZi1V80ELBcE/NAojIpX5FEZg4NfHjP
   nEkidB+kKXHmsPUrdrhT6G9LDY1sIo6HOKSlGQe/4sZ4imeY7kyzhjFpe
   IHmpYzXhteJQhwbCp3StGSiGv1ifyJXe8ayMK14/MxJRX6b3Rudl+KX93
   tssO4Q1Vdr0BAMnFhiaVFyF68LZJg17lg93z8kx1O2nnokPrFF3Cei00B
   xXSDZY0V+nNGzIOcR3BZYGp+a9m0PW7FVPGIQQ9ttJF2dbMe7JPjHbx3q
   A==;
X-CSE-ConnectionGUID: ttQoxB09TfOSg8QJkvncoA==
X-CSE-MsgGUID: yQwdiOAITDCZdNPucWbL6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="43532172"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="43532172"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 12:06:14 -0800
X-CSE-ConnectionGUID: jGKF4RFaQnuvu4bglKq29Q==
X-CSE-MsgGUID: uolMQRnxQoCcCgyqOwJTWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; 
   d="scan'208";a="112130752"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2025 12:06:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Feb 2025 12:06:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Feb 2025 12:06:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Feb 2025 12:06:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5eSkpXkEu8t64RwBzTf3F0c7ixN93ALEZ0uck+8k52b1Rg/hTfQNr4v8yY8Hcg7tqAQhLP+WpFCdLzZNQD033jVTSx5qUXTxf0D0JJFdhLqutEJXxWfvMSNCS1RUjddBmcC0qiUaCeDQoqEIajUio4qcjcFT+vhYOGVOXIMx9TJbWc9tHBdt9w8dmaHxdIF7KO/s8SKSqjPndV9tBRDf7sgJdbYrKRwQ9ssJIEjalJGmIj9LUCeKVKve9p/RVCZm1G9AvJPkbtRgUkFteDqdPtcUunEutWEUf/kqS3b+z6whQAFgbPWezJ9uDKe5bkyy5AhFMdxIG951DvqFouZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+afpeLDy4i1t0yHUI1ZOyOvqn7R5tForskLN1rI8oM=;
 b=HYEpB7xsjn63CCjjmse/x9rMUp41pP0zaQuIf32Cb/1q/9EHBzZbiEO16zsBIuEMq21c1kWyR+CN0UOdL4Pq+yie31WuIdb0WRw6DicUhGq1ZpcbBIPXmGvWJK5zgaVQDN02z02jJktxrsr2B9ItZHspiLH90blOQV4UEn+cwRDsYkP/gva5P23tIZRvkh2c0Ao/KUXn35DBk6sgKSp/d7fKJlfw0LxG91eNaRJx2V3GvP4dk7r6iv8wXj9osT0lPgSqJ8r34xtqG9/y3VYGpGFjpKh2TMxJadcbjPG7eVj+ArxVsSQbxCX52JrmfJWSk3UJ43XLxlg1jhUaRbJ2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH2PR11MB8865.namprd11.prod.outlook.com (2603:10b6:610:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 20:06:10 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 20:06:09 +0000
Date: Fri, 7 Feb 2025 12:06:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/mbox: Check enabled_cmds before sending
 SET_SHUTDOWN_STATE
Message-ID: <67a667af363d5_2d2c29477@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250207193427.1711233-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250207193427.1711233-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0143.namprd04.prod.outlook.com
 (2603:10b6:303:84::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH2PR11MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f0d4477-b441-40a5-464c-08dd47b2dd28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3sgHYqUCzy/IPcig3SuyBvP+lTVqpal+Di5k6d0AJn+M+uWR+XbyrmeO1ONw?=
 =?us-ascii?Q?loQhb9NZGyZaaZ4ZQV86MEWqsyJuC39OOgTJaLUXNsxDgIRKwivDsrIp6V3o?=
 =?us-ascii?Q?3n0MCm6bHtUNoxtx0raYCwOsVeVNvy2obl8HEl1X3dmLvwDw7Ds2MLf0SCZ5?=
 =?us-ascii?Q?s9vz02AYXjQ5NrXLtVKmU10mDClWCzP3uOp/BMQjqXvfX41dghPJlp7Y2/bG?=
 =?us-ascii?Q?gG20l+vpWdE5WEPM40TWGjrqqQ+F27fvpElZCUnIMzzSn1TOBXfiwpqjEHnp?=
 =?us-ascii?Q?JpnjPbmb7WoUsX9WlfuW91ohZF0pd6lCULVD01Qff0F7RootUOmQBCNRj+lI?=
 =?us-ascii?Q?Cz4U0k7L8WXhiqyprvINZmDiMkXL2djIS2n8zjrpvo/Cu24tPWkjsKzveQED?=
 =?us-ascii?Q?1y+mf8VHb6S5inZCO1Y9Tr7w2SeZEk7US5MP9A0rzTnnIwG7CBH+9y3HhWAF?=
 =?us-ascii?Q?ElXfWtcVEWdF36X0xlhicwqTO8691SWuyl+A5VEi71ZXbOf3PGwPuoBwnUcV?=
 =?us-ascii?Q?ElG7yH5NSFcXX+UNZqW6tcM94ERexFhg4ecJacjjRRc5cAcfFIif35xNvwWe?=
 =?us-ascii?Q?Kad96ZRiyVWcyh7JqLpfVWFb9Ul7y2e61EWrz7SdQpxv883uzoDtJw/cwXiO?=
 =?us-ascii?Q?THkFmDvk/YRZX/Nn6jRS81ghU0LhFqC5PtFbecFglUXhL7bEcvSWkPL+qM80?=
 =?us-ascii?Q?MjTs5RgtbuigXxCnOuQtjMthIDgxQF5AScRSBVAmakHVLB2V5DZqrMZOtaDd?=
 =?us-ascii?Q?kwqG0EmLMO0tZQVggpOseip7wfhN8oqhWaLHMGRB9hN+0bvoSc/FYylq29VX?=
 =?us-ascii?Q?8HhlylE5zFwM20KFfrBqm+0PBQc6xGvHfQmUfU2wjJS5+IaT8NfQF7z1Hx7I?=
 =?us-ascii?Q?P1OqNVQtUFgSFOGUwQCtBG2TZiEfYP9lrHWJLmHWrywpkHo80n9jhjqg/YaY?=
 =?us-ascii?Q?GK+7iYSoGnszf4ZsUs8yQrPXlttA/GVz8TpVyooh6RPwqPjbjYvWfjedc3P1?=
 =?us-ascii?Q?UQY2zjfRaCN1SIyAb3mO1pjagOHvXbszledbb3rK06p8/GyYXJaO1kBoBJpn?=
 =?us-ascii?Q?Ul5U49ax7k0Sm1HT82+uFpQAmvdyAPU9xza7w4rAxrk0QeqiazC6W7YLVUwH?=
 =?us-ascii?Q?7C2V4VECzJQ3E+PG4jL9PoyjWuXZbu2p7+lj2x4N0cfzK7wjNlq1L4sEew8L?=
 =?us-ascii?Q?A6aa8CNj/luu2KzMOmaBmromzH742b9VxFU/y0e/GDmMrEhdrUfLarxx0vYI?=
 =?us-ascii?Q?SL/55a58yB6R7CPeZbt8KwcCMEXSuaClJzPklBnQnFOh0e2QptniNaysR9z1?=
 =?us-ascii?Q?vt9wy7aELNLkTDFWmachDQhI73uw2nHVrDgC7UGY9uzvQQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+j1wJU/zMqN78wrKmr6T5qBX9jMbtiWLVz9qmIOx6DzpuuPVm9X0WNymHMxE?=
 =?us-ascii?Q?ldziMzvZ+nRDqtbMDjYg5nhNKhoTVaK/1V9H4mZ6Y+mHP3M6bR/WbcnIYQ2r?=
 =?us-ascii?Q?3BRDolQ355CRN3G69+ujG0HLv6htW2QAuUgnjNGuHwCsaCHZimbqoEO9/JcP?=
 =?us-ascii?Q?TK8qCYmM5NqSQ0aBEce49Z5L6Lxr9E3aJarPGHWePaeShmCxYy6eeg6XC70O?=
 =?us-ascii?Q?MxocWAE/+ffsHuHQJ+dnawVqHHgNJsAUqc+oLykC1O0nMF52shE6PYYXH6gM?=
 =?us-ascii?Q?yjqNumA4EhtBrXKfOgsk7lrHUflXmzPSI1543m7tYG1bIAOuNmhkOaRBwE9u?=
 =?us-ascii?Q?2/IZjGb/XUiaepoIJEfQ1INKjKlJTQBB+j4uN8CMkb2j/ddfkwMlfSWb7nKK?=
 =?us-ascii?Q?8TunnMRYol6HRulloq2Kb0ExwEJ0cfyE1huRmKqwAVlXOVhdOods2eo5/WQx?=
 =?us-ascii?Q?3xBy0Q3V+2NmmmpO+oAw26R6nAlyyAuzZKyehJhNj3xo9fOtDzCdAqflUw86?=
 =?us-ascii?Q?ZnKFvpsJz3ZZFsaV3XvNuT4FE1Mp3LouXLfNajJjN6M0K499c0OcdC14cQMQ?=
 =?us-ascii?Q?7PdvxN7V7WbLwN3M0nm+QTjdTl/cQqo/0B4EpKxrb84Opf1JaINlKgbhw71j?=
 =?us-ascii?Q?isuaeI0yRwwV6Kw+fSx4W9mlmoLjkGiDvTYU+ekpd2oITvKwBU0s8QdIRXdj?=
 =?us-ascii?Q?QISrNfzCrImv5zb6x5+5cnZtccEJNxh6eJgqi/QirtS7WWMrUzuik/ehHcAm?=
 =?us-ascii?Q?jJA97qzhYd6AeDB91MhbDlqda5/79zxu6BqSdtcv+gCq8Y9jqvdHuCn3Qpvd?=
 =?us-ascii?Q?RgKXE3klOAjXzLvS5aqSIB+yUGo/DG/HpeuIDpMpIxMZcGSsmAp+/ScuYFIC?=
 =?us-ascii?Q?mn61hOpaVup95huZCgbjXvk7Rt4WBU4iQIA28g0Xni0Fzj/1teiy3wPwxb6D?=
 =?us-ascii?Q?UN5MMPH2HYITsi32uQ3tix+mv6sUlMOpetJhqTvxg4AivtW1gK2hRnVW7ykZ?=
 =?us-ascii?Q?ujtDaXh/KaiWt8pIluZMLf9dFINL0IgR4FtODHIOrXpXCkl3XgVSJ5gORq7f?=
 =?us-ascii?Q?xRhDK5uifqH/DowldSwuqQsC85kdpQa2hJIE9jpPMy7g6lH5G7cmOz2h0FQc?=
 =?us-ascii?Q?Nbdbfd0X70LcgC3g4yZRBKmlzpqRWbjDuyMbYAbRrBya5lrNP6yQXAbGdGjB?=
 =?us-ascii?Q?k7q+VKkEfP4CCHBsUkUHpYKQGQV8b6Jj8YH56OYTN3mxd6PZuDLvrq2fkx2f?=
 =?us-ascii?Q?Pl6UFU+Zr9at0Kn0ZV844hFtm2S+FAIXInuKIWunxKnh8u8n6PV6cYByEf6N?=
 =?us-ascii?Q?R4cq+pt2QqMFTYsQdFT4HWEQxruOS5NqCPdUmGt4kR2bnb6MnviBu3TDfrq9?=
 =?us-ascii?Q?vtF0GG0rXC1b031NZ0CNukxFlLda3qU8eEyfAAAfJ92SHNDgD0efMcgcaeo8?=
 =?us-ascii?Q?42y1m5cQsxqYkGJwQvNmVc+3i09BL59Uu7rYfUToQJzBKaPo7owcE43aVrEa?=
 =?us-ascii?Q?aDjesuNDsgYC5BEGDTwgh+X6DzsrZbkFcGCGtj8ltW5YXOH4kLvlZ4iq4DK9?=
 =?us-ascii?Q?U783CIcy3I/unUpFH6iDFRIXvK4CBki0OGYgtMwlvJ5rdvB6a31bdlYsz3TR?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0d4477-b441-40a5-464c-08dd47b2dd28
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 20:06:09.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyZIUJXv19sZObcRKChSy4NtHG++zjGNeLyOwsc9UgmM45MJoXW3O2/R59uduaKj0xhdvg9aHGZCMTh9x16jNssLAQbJO19ANE43yPU0S9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8865
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL specification defines CXL_MBOX_OP_SET_SHUTDOWN_STATE as
> optional. Check the enabled_cmds bitmap before sending to device.

Table 8-126 defines it as mandatory for devices that support PMEM, see
the "PM" in the "Mailbox" column.

> This appeared with cxl-test where mock support for this command
> is not present and -EIO is returned, leading to a WARN_ONCE()
> stack trace and dev_warn()'s on every cxl_nvdimm_probe.

Davidlohr and I talked about this here:

http://lore.kernel.org/679430b145dc0_20fa2947b@dwillia2-xfh.jf.intel.com.notmuch

The plan was to follow up with mock device support... oh, that came in
on Tuesday, I need to go take a look at that:

http://lore.kernel.org/20250205040842.1253616-1-dave@stgolabs.net

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Not sure what we actually want to do when not supported.
> Most cmds just return 0, like I did here, but maybe for
> this functionality something more is warranted.
> 
> wrt cxl-test support, also not sure if this feature wants some
> round-trip testing support via cxl-test mocking. I do like the
> -EIO from cxl-test as a loud reminder when running cxl-test 
> that something new has come in that cxl-test doesn't know about.

Have a look at that follow-up series and see if it addresses the
concerns.
