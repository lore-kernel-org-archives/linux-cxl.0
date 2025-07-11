Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603B2288E3;
	Fri, 11 Jul 2025 23:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277794; cv=fail; b=dEDC5utWoISOvRW2ygNO3GkpcGjcfE893ZEzfJ/wVDouGSWy8myhu3GVrhFDJjydLyXKWiRAbkOefhJy5kqjtLKuwMuwClSHwAxPtllk6WlRZxGCVHcQeAfTau3aLfeQL+fmP27aGsmZmogt/4/3+aSDxNigi5O0zT2qwC+5i6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277794; c=relaxed/simple;
	bh=jomaYeGeLq7UIJZD4QQG6XuDH5dOUQ/vE8VBED7hqyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J4JvLkpuNvTqk1w4sXPqvDo5HH+v89IuWqJw48wPb7ZYsuqmEHRgeWdSpA9muI8qPYj4SpcZPhL5EPiTmcoFmOl5AlO4iirwqJKPvlxB0GL3MLgEanm947ArdUhTfaaQ4A//Ymq1YcfLCRcSv4IYV4iiIDEJbREuHD08K6/pYzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJ1DpZyx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJ1DpZyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277791; x=1783813791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=jomaYeGeLq7UIJZD4QQG6XuDH5dOUQ/vE8VBED7hqyI=;
  b=hJ1DpZyxYgB43Ea/w9EiLW2P5B+W+ZWkNpahaJ1pFMGH8jkwbg8388Wq
   /be0AXqygxQsNwtFodoyD8+yIM3sSrG56HVFcU9Xu0998e3c5pA59IGBy
   e4qyvS3VCo2aNeVdqbvJphtS4eFAA/sIYbU0Si+0LbJ/gho4Gkctc1cM/
   75nXMRU42b9VRPxt0YdpqyPLDBrMqKss2dtwyDlh+LwBgoVbYQLdYmIKP
   98MuX/LfiKublbn72OceSiNnIO+7S36U+0sPeZYOxWQQDaKeP5mOtvOKZ
   Xdvs7/wr4MRUHJ0OUW0elldiiXYIs9U8pQ8S6ya06FTWs127hz4W4X0ix
   Q==;
X-CSE-ConnectionGUID: di7B8Gv3RICp3oM8vWJ2fQ==
X-CSE-MsgGUID: HFWGlxXlTbevAPjbhWKwbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54547692"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54547692"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:47 -0700
X-CSE-ConnectionGUID: 3ca93H5OSTiMJmrEK3nUAw==
X-CSE-MsgGUID: FLSSHzkVT4iFJRVNX6fXKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162048569"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:49:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.44)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH8KY7Iyn/aU1mzkxQM5kaA9TbjPNZnwvb8H7i/uI5XCVF3zTJQmrriQ7zT8TevCXzfELHDOvv98l74siOo1Nr81qKUYV+Vq6DmPHim805pJ/8vT555FGOGnpw8VcuMK8Bw7lFTkL5+UFjGy/PYL6/NPYyFj0A5nh8Oe4hbVBdoVGemVbf8LBt6RR5KEJGL0etu/jV4AkU/J+dGcIjqvfM4yWi4pK2DSblD/AFXYHvDXqB5cNj0nqvqCBShOj2umJUYnMVLeLvlFctlt/L8X1U+hkSWOwKrHZcDsdsOSWFE4gZQQuio9gD9D0Y5df97vrfjCApPexg/l+7so9NTpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbq0bpAHwlqAb3ZgoGfK1GvS6gSggS+9BB01eK53D64=;
 b=de9tQ7EK3caJe+OEuJPLpAl/uopsbXbPhYaz61kfOuPI67bcT5XVQT9D0ZXiEMK/3qJmaLhR1CbiorMobHjFXmHNJrNAeqk6RuaEpmx+ELZ3i75bW/7N9SfpYyarNnHqa9cpIm+T2ZNcXOdHIJvPnvZkuBotlKm0cSWUbB6WKN1pkhKyjLW/tCibavnFB0aKrfC2IZT3oj2TO18YpuUbQLgNNIiEgiGxlqLaE9AtdLW9jEot6QZWJaiiZBPaPJpfDAJEE2VPnzrDYh2nEpRudgP8YJ0BYcw7y+4wD8JNGxdLCqbrPdiCn/EtnQY0Z2wX7p9txsYZRVk6qvNmSq6blg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9352.namprd11.prod.outlook.com (2603:10b6:208:575::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 23:49:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:42 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Fabio M. De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem locking
Date: Fri, 11 Jul 2025 16:49:32 -0700
Message-ID: <20250711234932.671292-9-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711234932.671292-1-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dc3037-a0ed-473c-f273-08ddc0d59b95
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ecp4ZPd1IA4aJi5/asREg1RDKr6NorxCXAvHrIcfpT/RJJcqzxJ115eZEzZd?=
 =?us-ascii?Q?43ek8yhPxw04D1MB+gxQlRWDLgzCkuqwPg2ltfTf/xv2inaZV8magrOiQb6h?=
 =?us-ascii?Q?FZydUFOQnzRNcd3M0arQDznOiOTJwF63Fij0v5+YF7566nf27xT/VDbVpSaO?=
 =?us-ascii?Q?674wlPzetxzCmSuh+1B0ZGvTMmZXNuKZSRXGMW4/FQTgg83nyjoMn6BCguL4?=
 =?us-ascii?Q?LhFkm+riDzF6w47iIF7mjzvqNAfZMp93ZWD6K3nrC04CpGxYScwL01oDX46p?=
 =?us-ascii?Q?DxZWd8tkHazR/B/iblIIbcxKgF2BZ5anyg2WoEg5r3E1DxcJdwN/nCnBlxse?=
 =?us-ascii?Q?ejdvxBA/GTVELRozuD5s7wOWXLlomfmKlparvBB/E55AlCsY+9X/2oxpm7ta?=
 =?us-ascii?Q?t6Aj6Va3aZCnh6LsPNdUEF+EcxKFcN4f4+hdQZh/hcFslJmPE62/EVLfLQPS?=
 =?us-ascii?Q?8vCbUSeGi6ZMC4XvSUWOVmIpzw0Z7nKxwE1I1RIDjUdMBdlwPTrKB5q3fZwW?=
 =?us-ascii?Q?AwWvjRKKa6JK9OA1/7gysx1lfXrp2LNLZ57U/Rkft8KOwsvVJ5i5JstZNvWo?=
 =?us-ascii?Q?OoKR5S9rzZd+NjwzVoxTDjbG21i4nYf/bSnQNP+kMcmTw80J8lap+ueQIc/8?=
 =?us-ascii?Q?ZMDjQ299ETQwwhaN7M4BJHahvTtRErEIWxdbfVV5HS07vD4cQNG9UObRLf2y?=
 =?us-ascii?Q?TRQELGnD60JmB2o2ylpV+2K8cSJQjEJNxb8J2f9/g7ObRrtk8EULGvPdFj++?=
 =?us-ascii?Q?fnRgZnVyKBVs9Z5c2VETEACkY4QGPqaHo6JaMHYOfmkFjz1xDbh85tpq6B8I?=
 =?us-ascii?Q?k18zeJhGK46QsuJjRE+BPxe/iMY8OIqAq2+QHUrmN0KMkNP6j6c1xJn5rhcY?=
 =?us-ascii?Q?+QlqQIJfSJ9VtPrJbJ6ocdRj1klXCWyn4R+oTO3EAOzKcjRGkZR1fNZY/hQB?=
 =?us-ascii?Q?CM/EhmavFT1ocfz4NYNATDh03tdTdRl7t8Zx9B3EcBgx05J2lYG1IBiFTGSf?=
 =?us-ascii?Q?MmtSuEWBMGte4zD7AkNs+NzQEy3IXE0pKsd7ZUI3M7F/xDnX5gz2okTv2o8W?=
 =?us-ascii?Q?8VbSsv9D6rQZoYjXSqk1+PdZtCWmdZS9p0d14Q0jBurdwJhprXarnCNg1x5n?=
 =?us-ascii?Q?IXAz9+uS1XLVpUw2VBiP183qb8kvjGXjfnEB72oeB90pLsOYay0KyoY9zvZ7?=
 =?us-ascii?Q?d8xKz5hB/zH4dr1DJhqzoueywAKzV+zf4DTXESxEzbR99/nylpn6YdtyiVr5?=
 =?us-ascii?Q?LA8KXeyKgm+vaJqnxX6SlAUuejwOPRJ4EoyAnwNIb6eJQw5dqzTAQmsaHaOx?=
 =?us-ascii?Q?KPBIyfuPm9uBFDUtbpAToEnOOgpniqe7zfa/yFiruZWKVkbW0I7TP7ih8ivw?=
 =?us-ascii?Q?WpRijTfGPiGmLbpfwlRbFc4JGJbMwGiiv0IF0NL0n+UwQ7jldAVmesFxL28n?=
 =?us-ascii?Q?8mhj5AMnk5Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ks1vibYxQsYoYRrXxy1VuHFJmJ+z8XZMH9IxcMXFjQ/0SRvIVKAXmMhknBZ6?=
 =?us-ascii?Q?U9YawxmL9OOMd7W3fA+94/4rN/dKzOZT6DIvM6yxdI6uyXk1gbx3ypsBr8gc?=
 =?us-ascii?Q?tcN4vAD9KgsR6YO8284xlvwaKiscUK/2LV3N35BpDZFVy1SOZ8CYRzjU0N5U?=
 =?us-ascii?Q?8KGIGCIEhL4/rkjUZnOcTUVyz1mPQG+9i5rwiQF/8G5zoKchvRbQMlyvLkHk?=
 =?us-ascii?Q?TkjZLpr5vX3Fq1aLi77Bg6lv0Iu369Wtsoyz/OZNf/8bdlrV9Me4PwtJYsBe?=
 =?us-ascii?Q?0V/kxX/Z0/zN/IDrHTbuTJLyKUDF5jKnELvGpG0Y9Zkslebcz6Om+dgmWBm/?=
 =?us-ascii?Q?hK2DrDCpGAteKMXN3CgOFIh1lT7jIbubetp7QSoFPhaUEgNvkiyan4buPNF/?=
 =?us-ascii?Q?6GMoPa1l9ExWVyL2r7Ged/JD1/XZK+5mMMP5+5kG7LWpezFsHB6r9Fu5/EbV?=
 =?us-ascii?Q?Fuvg1BIvAo8pbDwaCkQu4NxoymhpQfV0E/jxGt63+6icCdrvXpH9pl8BNAQw?=
 =?us-ascii?Q?kc1/JvQ6BhDfmpa1Br2G3Whoo5lCf+ePwwkkZvmyS5FPTttxZjGLOWGKRe7z?=
 =?us-ascii?Q?s0yv+iC+MKt6g/27x62Ao/mdYv1CkWvKgii5EDViOAY16lTowCQ70eFItIUV?=
 =?us-ascii?Q?U7qoh/hQq9M/ETj9mKDFr24zYUJYsuNSc/2ULxP42tnV6Qyxc4CE3gIX7P1/?=
 =?us-ascii?Q?DTUJrK21hflRyrNek+jTzyuksDqjlIMFc9mYyB2r6QcjAoXH+UV71HpO4lsL?=
 =?us-ascii?Q?kSLF6gN3bpAPMNcTWPIPgSeivvzQRbNY3uZWgzK6pX1egORAXxIOTwB8AVQf?=
 =?us-ascii?Q?y0YAvvwyeWHvKjpinFMWwJpnrxpuHpVaAEMApIPKxB7EVPA7ZeS1s0SFyh9y?=
 =?us-ascii?Q?hgivAI5Gx6kp1CBS4rF4PCKPtG0fWDxSmxyDIeEN0OwR5RxLNu+sLOfGlKAn?=
 =?us-ascii?Q?oF2bVjNwfV220JhGvPoeU9UAh+uClSvIyEcrpiEWbtXXOSveJI+HWZhxykE9?=
 =?us-ascii?Q?r4lBeuqfOiJMkZyxX/sZ8uOGMvuu/DeWjWfJd2uxsAW9y8DKOU0wxlunDGvh?=
 =?us-ascii?Q?YPlnnvHRk5EDPiP+QTlKdIJxUltLiAgdOS34i0cBrINOq4dRD4yzdAkJd4Nt?=
 =?us-ascii?Q?fW3/GHByA1XrHCXLpDz/iYMsg3QeUmRQcATht1xpatJahLpEeRa/KFGOL6a1?=
 =?us-ascii?Q?w2BxwWiynbnJJ1I3yR8J52VH8j+WQpy467C8bklSnWI0S37OQ2uJsT0WFOJH?=
 =?us-ascii?Q?albJukD8mAUA1tkqQKCrIkRo98gvxYqxhuuYufzQyzLkXEyQd6UijtO0QG+O?=
 =?us-ascii?Q?A2gg6MTm9XQ2pxgb7l+CQ0quKERouZjNv6T8pXTi2lsO6XbXsi4xewYsP0ol?=
 =?us-ascii?Q?v5T1rF7D/c1FCT1MgVkvjh72cgwOmRvKo7jTc2X1tmSvCMmWNfVAOHtb5aTc?=
 =?us-ascii?Q?KpXnJ1Sm8i8ohkZhxGWSN1cKx0mfiLYgx1xMfbF382RuxNVplZLvgNbyjosx?=
 =?us-ascii?Q?JKefAQK3ju4EBtB1I3dsbbLltg6VCd9U2RrBhqztnasUYngGvy42G5V1CqnZ?=
 =?us-ascii?Q?gnAjL85luwf4joWEVcDFqw2XviftFjj8Ma1NQdLMyd3xjmU7irH6Dlryl6vD?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dc3037-a0ed-473c-f273-08ddc0d59b95
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:42.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuLtKJCuH9JklzQj0v2E7xjIvNnWehTzNZ/whaGf2v5USoBsnqQ3TOtfqpY431u4oD3WMHb/DMZI256COCTRJ1m41b8NKlP3eSjWP0DvHc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9352
X-OriginatorOrg: intel.com

Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
representing the state of the conditional lock.

The goal of this conversion is to complete the removal of all explicit
unlock calls in the subsystem. I.e. the methods to acquire a lock are
solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
unlock is implicit / scope-based. In order to make sure all lock sites are
converted, the existing rwsem's are consolidated and renamed in 'struct
cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
between old-world (explicit unlock allowed), and new world (explicit unlock
deleted).

Cc: David Lechner <dlechner@baylibre.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Shiju Jose <shiju.jose@huawei.com>
Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/cdat.c   |   6 +-
 drivers/cxl/core/core.h   |  17 ++-
 drivers/cxl/core/edac.c   |  44 +++---
 drivers/cxl/core/hdm.c    |  41 +++---
 drivers/cxl/core/mbox.c   |   6 +-
 drivers/cxl/core/memdev.c |  50 +++----
 drivers/cxl/core/port.c   |  18 +--
 drivers/cxl/core/region.c | 295 ++++++++++++++++----------------------
 drivers/cxl/cxl.h         |  13 +-
 include/linux/rwsem.h     |   1 +
 10 files changed, 212 insertions(+), 279 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 0ccef2f2a26a..c0af645425f4 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -336,7 +336,7 @@ static int match_cxlrd_hb(struct device *dev, void *data)
 	cxlrd = to_cxl_root_decoder(dev);
 	cxlsd = &cxlrd->cxlsd;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	for (int i = 0; i < cxlsd->nr_targets; i++) {
 		if (host_bridge == cxlsd->target[i]->dport_dev)
 			return 1;
@@ -987,7 +987,7 @@ void cxl_region_shared_upstream_bandwidth_update(struct cxl_region *cxlr)
 	bool is_root;
 	int rc;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_rwsem.dpa);
 
 	struct xarray *usp_xa __free(free_perf_xa) =
 		kzalloc(sizeof(*usp_xa), GFP_KERNEL);
@@ -1057,7 +1057,7 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 {
 	struct cxl_dpa_perf *perf;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_rwsem.dpa);
 
 	perf = cxled_get_dpa_perf(cxled);
 	if (IS_ERR(perf))
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2be37084409f..f796731deedf 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -5,6 +5,7 @@
 #define __CXL_CORE_H__
 
 #include <cxl/mailbox.h>
+#include <linux/rwsem.h>
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
@@ -107,8 +108,20 @@ u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
 #define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
 #define PCI_CAP_EXP_SIZEOF		0x3c
 
-extern struct rw_semaphore cxl_dpa_rwsem;
-extern struct rw_semaphore cxl_region_rwsem;
+struct cxl_rwsem {
+	/*
+	 * All changes to HPA (interleave configuration) occur with this
+	 * lock held for write.
+	 */
+	struct rw_semaphore region;
+	/*
+	 * All changes to a device DPA space occur with this lock held
+	 * for write.
+	 */
+	struct rw_semaphore dpa;
+};
+
+extern struct cxl_rwsem cxl_rwsem;
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
index 2cbc664e5d62..f1ebdbe222c8 100644
--- a/drivers/cxl/core/edac.c
+++ b/drivers/cxl/core/edac.c
@@ -115,10 +115,9 @@ static int cxl_scrub_get_attrbs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
 						flags, min_cycle);
 	}
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return ret;
 
 	cxlr = cxl_ps_ctx->cxlr;
 	p = &cxlr->params;
@@ -154,10 +153,9 @@ static int cxl_scrub_set_attrbs_region(struct device *dev,
 	struct cxl_region *cxlr;
 	int ret, i;
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
+		return ret;
 
 	cxlr = cxl_ps_ctx->cxlr;
 	p = &cxlr->params;
@@ -1332,16 +1330,15 @@ cxl_mem_perform_sparing(struct device *dev,
 	struct cxl_memdev_sparing_in_payload sparing_pi;
 	struct cxl_event_dram *rec = NULL;
 	u16 validity_flags = 0;
+	int ret;
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return ret;
 
-	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
-	if (!dpa_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return ret;
 
 	if (!cxl_sparing_ctx->cap_safe_when_in_use) {
 		/* Memory to repair must be offline */
@@ -1779,16 +1776,15 @@ static int cxl_mem_perform_ppr(struct cxl_ppr_context *cxl_ppr_ctx)
 	struct cxl_memdev_ppr_maintenance_attrbs maintenance_attrbs;
 	struct cxl_memdev *cxlmd = cxl_ppr_ctx->cxlmd;
 	struct cxl_mem_repair_attrbs attrbs = { 0 };
+	int ret;
 
-	struct rw_semaphore *region_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_region_rwsem);
-	if (!region_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
+		return ret;
 
-	struct rw_semaphore *dpa_lock __free(rwsem_read_release) =
-		rwsem_read_intr_acquire(&cxl_dpa_rwsem);
-	if (!dpa_lock)
-		return -EINTR;
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((ret = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
+		return ret;
 
 	if (!cxl_ppr_ctx->media_accessible || !cxl_ppr_ctx->data_retained) {
 		/* Memory to repair must be offline */
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e9cb34e30248..865a71bce251 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -16,7 +16,10 @@
  * for enumerating these registers and capabilities.
  */
 
-DECLARE_RWSEM(cxl_dpa_rwsem);
+struct cxl_rwsem cxl_rwsem = {
+	.region = __RWSEM_INITIALIZER(cxl_rwsem.region),
+	.dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
+};
 
 static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			   int *target_map)
@@ -214,7 +217,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 {
 	struct resource *p1, *p2;
 
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
 	for (p1 = cxlds->dpa_res.child; p1; p1 = p1->sibling) {
 		__cxl_dpa_debug(file, p1, 0);
 		for (p2 = p1->child; p2; p2 = p2->sibling)
@@ -266,7 +269,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	struct resource *res = cxled->dpa_res;
 	resource_size_t skip_start;
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
 	/* save @skip_start, before @res is released */
 	skip_start = res->start - cxled->skip;
@@ -281,7 +284,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 
 static void cxl_dpa_release(void *cxled)
 {
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	__cxl_dpa_release(cxled);
 }
 
@@ -293,7 +296,7 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
 	devm_remove_action(&port->dev, cxl_dpa_release, cxled);
 	__cxl_dpa_release(cxled);
 }
@@ -361,7 +364,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct resource *res;
 	int rc;
 
-	lockdep_assert_held_write(&cxl_dpa_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
 
 	if (!len) {
 		dev_warn(dev, "decoder%d.%d: empty reservation attempted\n",
@@ -470,7 +473,7 @@ int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
 {
 	struct device *dev = cxlds->dev;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 
 	if (cxlds->nr_partitions)
 		return -EBUSY;
@@ -516,9 +519,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	struct cxl_port *port = cxled_to_port(cxled);
 	int rc;
 
-	down_write(&cxl_dpa_rwsem);
-	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
-	up_write(&cxl_dpa_rwsem);
+	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
+		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
 
 	if (rc)
 		return rc;
@@ -529,7 +531,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 {
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
 	if (cxled->dpa_res)
 		return resource_size(cxled->dpa_res);
 
@@ -540,7 +542,7 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 {
 	resource_size_t base = -1;
 
-	lockdep_assert_held(&cxl_dpa_rwsem);
+	lockdep_assert_held(&cxl_rwsem.dpa);
 	if (cxled->dpa_res)
 		base = cxled->dpa_res->start;
 
@@ -552,7 +554,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	struct cxl_port *port = cxled_to_port(cxled);
 	struct device *dev = &cxled->cxld.dev;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	if (!cxled->dpa_res)
 		return 0;
 	if (cxled->cxld.region) {
@@ -582,7 +584,7 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	struct device *dev = &cxled->cxld.dev;
 	int part;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
 		return -EBUSY;
 
@@ -614,7 +616,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	struct resource *p, *last;
 	int part;
 
-	guard(rwsem_write)(&cxl_dpa_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder attached to %s\n",
 			dev_name(&cxled->cxld.region->dev));
@@ -842,9 +844,8 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		}
 	}
 
-	down_read(&cxl_dpa_rwsem);
-	setup_hw_decoder(cxld, hdm);
-	up_read(&cxl_dpa_rwsem);
+	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
+		setup_hw_decoder(cxld, hdm);
 
 	port->commit_end++;
 	rc = cxld_await_commit(hdm, cxld->id);
@@ -882,7 +883,7 @@ void cxl_port_commit_reap(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	/*
 	 * Once the highest committed decoder is disabled, free any other
@@ -1030,7 +1031,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
 
-		guard(rwsem_write)(&cxl_region_rwsem);
+		guard(rwsem_write)(&cxl_rwsem.region);
 		if (cxld->id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 81b21effe8cf..92cd3cbdd8ec 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -909,8 +909,8 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 		 * translations. Take topology mutation locks and lookup
 		 * { HPA, REGION } from { DPA, MEMDEV } in the event record.
 		 */
-		guard(rwsem_read)(&cxl_region_rwsem);
-		guard(rwsem_read)(&cxl_dpa_rwsem);
+		guard(rwsem_read)(&cxl_rwsem.region);
+		guard(rwsem_read)(&cxl_rwsem.dpa);
 
 		dpa = le64_to_cpu(evt->media_hdr.phys_addr) & CXL_DPA_MASK;
 		cxlr = cxl_dpa_to_region(cxlmd, dpa);
@@ -1265,7 +1265,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	/* synchronize with cxl_mem_probe() and decoder write operations */
 	guard(device)(&cxlmd->dev);
 	endpoint = cxlmd->endpoint;
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	/*
 	 * Require an endpoint to be safe otherwise the driver can not
 	 * be sure that the device is unmapped.
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..f5fbd34310fd 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -232,15 +232,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 	if (!port || !is_cxl_endpoint(port))
 		return -EINVAL;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
-	}
 
 	if (cxl_num_decoders_committed(port) == 0) {
 		/* No regions mapped to this memdev */
@@ -249,8 +247,6 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
 		/* Regions mapped, collect poison by endpoint */
 		rc =  cxl_get_poison_by_endpoint(port);
 	}
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
 	return rc;
 }
@@ -292,19 +288,17 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
-	}
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	inject.address = cpu_to_le64(dpa);
 	mbox_cmd = (struct cxl_mbox_cmd) {
@@ -314,7 +308,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	};
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -327,11 +321,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, "CXL");
 
@@ -347,19 +338,17 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 
-	rc = down_read_interruptible(&cxl_dpa_rwsem);
-	if (rc) {
-		up_read(&cxl_region_rwsem);
+	ACQUIRE(rwsem_read_intr, dpa_rwsem)(&cxl_rwsem.dpa);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &dpa_rwsem)))
 		return rc;
-	}
 
 	rc = cxl_validate_poison_dpa(cxlmd, dpa);
 	if (rc)
-		goto out;
+		return rc;
 
 	/*
 	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
@@ -378,7 +367,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 
 	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
 	if (rc)
-		goto out;
+		return rc;
 
 	cxlr = cxl_dpa_to_region(cxlmd, dpa);
 	if (cxlr)
@@ -391,11 +380,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.length = cpu_to_le32(1),
 	};
 	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
-out:
-	up_read(&cxl_dpa_rwsem);
-	up_read(&cxl_region_rwsem);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, "CXL");
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 087a20a9ee1c..bacf1380dc4d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -30,18 +30,12 @@
  * instantiated by the core.
  */
 
-/*
- * All changes to the interleave configuration occur with this lock held
- * for write.
- */
-DECLARE_RWSEM(cxl_region_rwsem);
-
 static DEFINE_IDA(cxl_port_ida);
 static DEFINE_XARRAY(cxl_root_buses);
 
 int cxl_num_decoders_committed(struct cxl_port *port)
 {
-	lockdep_assert_held(&cxl_region_rwsem);
+	lockdep_assert_held(&cxl_rwsem.region);
 
 	return port->commit_end + 1;
 }
@@ -176,7 +170,7 @@ static ssize_t target_list_show(struct device *dev,
 	ssize_t offset;
 	int rc;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	rc = emit_target_list(cxlsd, buf);
 	if (rc < 0)
 		return rc;
@@ -196,7 +190,7 @@ static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	/* without @cxl_dpa_rwsem, make sure @part is not reloaded */
+	/* without @cxl_rwsem.dpa, make sure @part is not reloaded */
 	int part = READ_ONCE(cxled->part);
 	const char *desc;
 
@@ -235,7 +229,7 @@ static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *at
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 
-	guard(rwsem_read)(&cxl_dpa_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
 	return sysfs_emit(buf, "%#llx\n", (u64)cxl_dpa_resource_start(cxled));
 }
 static DEVICE_ATTR_RO(dpa_resource);
@@ -560,7 +554,7 @@ static ssize_t decoders_committed_show(struct device *dev,
 {
 	struct cxl_port *port = to_cxl_port(dev);
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	return sysfs_emit(buf, "%d\n", cxl_num_decoders_committed(port));
 }
 
@@ -1722,7 +1716,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 	if (xa_empty(&port->dports))
 		return -EINVAL;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4314aaed8ad8..ad60c93be803 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -141,16 +141,12 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region_params *p = &cxlr->params;
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
 		return rc;
 	if (cxlr->mode != CXL_PARTMODE_PMEM)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%pUb\n", &p->uuid);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%pUb\n", &p->uuid);
 }
 
 static int is_dup(struct device *match, void *data)
@@ -162,7 +158,7 @@ static int is_dup(struct device *match, void *data)
 	if (!is_cxl_region(match))
 		return 0;
 
-	lockdep_assert_held(&cxl_region_rwsem);
+	lockdep_assert_held(&cxl_rwsem.region);
 	cxlr = to_cxl_region(match);
 	p = &cxlr->params;
 
@@ -192,27 +188,22 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 	if (uuid_is_null(&temp))
 		return -EINVAL;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, region_rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &region_rwsem)))
 		return rc;
 
 	if (uuid_equal(&p->uuid, &temp))
-		goto out;
+		return len;
 
-	rc = -EBUSY;
 	if (p->state >= CXL_CONFIG_ACTIVE)
-		goto out;
+		return -EBUSY;
 
 	rc = bus_for_each_dev(&cxl_bus_type, NULL, &temp, is_dup);
 	if (rc < 0)
-		goto out;
+		return rc;
 
 	uuid_copy(&p->uuid, &temp);
-out:
-	up_write(&cxl_region_rwsem);
 
-	if (rc)
-		return rc;
 	return len;
 }
 static DEVICE_ATTR_RW(uuid);
@@ -354,20 +345,17 @@ static int queue_reset(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
 
 	/* Already in the requested state? */
 	if (p->state < CXL_CONFIG_COMMIT)
-		goto out;
+		return 0;
 
 	p->state = CXL_CONFIG_RESET_PENDING;
 
-out:
-	up_write(&cxl_region_rwsem);
-
-	return rc;
+	return 0;
 }
 
 static int __commit(struct cxl_region *cxlr)
@@ -375,19 +363,17 @@ static int __commit(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
 
 	/* Already in the requested state? */
 	if (p->state >= CXL_CONFIG_COMMIT)
-		goto out;
+		return 0;
 
 	/* Not ready to commit? */
-	if (p->state < CXL_CONFIG_ACTIVE) {
-		rc = -ENXIO;
-		goto out;
-	}
+	if (p->state < CXL_CONFIG_ACTIVE)
+		return -ENXIO;
 
 	/*
 	 * Invalidate caches before region setup to drop any speculative
@@ -395,16 +381,15 @@ static int __commit(struct cxl_region *cxlr)
 	 */
 	rc = cxl_region_invalidate_memregion(cxlr);
 	if (rc)
-		goto out;
+		return rc;
 
 	rc = cxl_region_decode_commit(cxlr);
-	if (rc == 0)
-		p->state = CXL_CONFIG_COMMIT;
+	if (rc)
+		return rc;
 
-out:
-	up_write(&cxl_region_rwsem);
+	p->state = CXL_CONFIG_COMMIT;
 
-	return rc;
+	return 0;
 }
 
 static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
@@ -437,10 +422,10 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	device_release_driver(&cxlr->dev);
 
 	/*
-	 * With the reset pending take cxl_region_rwsem unconditionally
+	 * With the reset pending take cxl_rwsem.region unconditionally
 	 * to ensure the reset gets handled before returning.
 	 */
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 
 	/*
 	 * Revalidate that the reset is still pending in case another
@@ -461,13 +446,10 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region_params *p = &cxlr->params;
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->state >= CXL_CONFIG_COMMIT);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%d\n", p->state >= CXL_CONFIG_COMMIT);
 }
 static DEVICE_ATTR_RW(commit);
 
@@ -491,15 +473,12 @@ static ssize_t interleave_ways_show(struct device *dev,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
+	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->interleave_ways);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%d\n", p->interleave_ways);
 }
 
 static const struct attribute_group *get_cxl_region_target_group(void);
@@ -534,23 +513,21 @@ static ssize_t interleave_ways_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	save = p->interleave_ways;
 	p->interleave_ways = val;
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
-	if (rc)
+	if (rc) {
 		p->interleave_ways = save;
-out:
-	up_write(&cxl_region_rwsem);
-	if (rc)
 		return rc;
+	}
+
 	return len;
 }
 static DEVICE_ATTR_RW(interleave_ways);
@@ -561,15 +538,12 @@ static ssize_t interleave_granularity_show(struct device *dev,
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	ssize_t rc;
+	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
-	rc = sysfs_emit(buf, "%d\n", p->interleave_granularity);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
 static ssize_t interleave_granularity_store(struct device *dev,
@@ -602,19 +576,15 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
+
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
 
 	p->interleave_granularity = val;
-out:
-	up_write(&cxl_region_rwsem);
-	if (rc)
-		return rc;
+
 	return len;
 }
 static DEVICE_ATTR_RW(interleave_granularity);
@@ -625,17 +595,15 @@ static ssize_t resource_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
 	u64 resource = -1ULL;
-	ssize_t rc;
+	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
+
 	if (p->res)
 		resource = p->res->start;
-	rc = sysfs_emit(buf, "%#llx\n", resource);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%#llx\n", resource);
 }
 static DEVICE_ATTR_RO(resource);
 
@@ -663,7 +631,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	struct resource *res;
 	u64 remainder = 0;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	/* Nothing to do... */
 	if (p->res && resource_size(p->res) == size)
@@ -705,7 +673,7 @@ static void cxl_region_iomem_release(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 
 	if (device_is_registered(&cxlr->dev))
-		lockdep_assert_held_write(&cxl_region_rwsem);
+		lockdep_assert_held_write(&cxl_rwsem.region);
 	if (p->res) {
 		/*
 		 * Autodiscovered regions may not have been able to insert their
@@ -722,7 +690,7 @@ static int free_hpa(struct cxl_region *cxlr)
 {
 	struct cxl_region_params *p = &cxlr->params;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (!p->res)
 		return 0;
@@ -746,15 +714,14 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	rc = down_write_killable(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 		return rc;
 
 	if (val)
 		rc = alloc_hpa(cxlr, val);
 	else
 		rc = free_hpa(cxlr);
-	up_write(&cxl_region_rwsem);
 
 	if (rc)
 		return rc;
@@ -770,15 +737,12 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 	u64 size = 0;
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
 	if (p->res)
 		size = resource_size(p->res);
-	rc = sysfs_emit(buf, "%#llx\n", size);
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+	return sysfs_emit(buf, "%#llx\n", size);
 }
 static DEVICE_ATTR_RW(size);
 
@@ -804,26 +768,20 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	struct cxl_endpoint_decoder *cxled;
 	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
 
 	if (pos >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
 			p->interleave_ways);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	cxled = p->targets[pos];
 	if (!cxled)
-		rc = sysfs_emit(buf, "\n");
-	else
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
-out:
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
 }
 
 static int check_commit_order(struct device *dev, void *data)
@@ -938,7 +896,7 @@ cxl_port_pick_region_decoder(struct cxl_port *port,
 	/*
 	 * This decoder is pinned registered as long as the endpoint decoder is
 	 * registered, and endpoint decoder unregistration holds the
-	 * cxl_region_rwsem over unregister events, so no need to hold on to
+	 * cxl_rwsem.region over unregister events, so no need to hold on to
 	 * this extra reference.
 	 */
 	put_device(dev);
@@ -1129,7 +1087,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	unsigned long index;
 	int rc = -EBUSY;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	cxl_rr = cxl_rr_load(port, cxlr);
 	if (cxl_rr) {
@@ -1239,7 +1197,7 @@ static void cxl_port_detach_region(struct cxl_port *port,
 	struct cxl_region_ref *cxl_rr;
 	struct cxl_ep *ep = NULL;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	cxl_rr = cxl_rr_load(port, cxlr);
 	if (!cxl_rr)
@@ -2142,7 +2100,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 {
 	struct cxl_region_params *p;
 
-	lockdep_assert_held_write(&cxl_region_rwsem);
+	lockdep_assert_held_write(&cxl_rwsem.region);
 
 	if (!cxled) {
 		p = &cxlr->params;
@@ -2215,18 +2173,18 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	struct cxl_region *detach;
 
 	/* when the decoder is being destroyed lock unconditionally */
-	if (mode == DETACH_INVALIDATE)
-		down_write(&cxl_region_rwsem);
-	else {
-		int rc = down_write_killable(&cxl_region_rwsem);
+	if (mode == DETACH_INVALIDATE) {
+		guard(rwsem_write)(&cxl_rwsem.region);
+		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
+	} else {
+		int rc;
 
-		if (rc)
+		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
 			return rc;
+		detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
 	}
 
-	detach = __cxl_decoder_detach(cxlr, cxled, pos, mode);
-	up_write(&cxl_region_rwsem);
-
 	if (detach) {
 		device_release_driver(&detach->dev);
 		put_device(&detach->dev);
@@ -2234,29 +2192,35 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
 	return 0;
 }
 
+static int __attach_target(struct cxl_region *cxlr,
+			   struct cxl_endpoint_decoder *cxled, int pos,
+			   unsigned int state)
+{
+	int rc;
+
+	if (state == TASK_INTERRUPTIBLE) {
+		ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+		if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+			return rc;
+		guard(rwsem_read)(&cxl_rwsem.dpa);
+		return cxl_region_attach(cxlr, cxled, pos);
+	}
+	guard(rwsem_write)(&cxl_rwsem.region);
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	return cxl_region_attach(cxlr, cxled, pos);
+}
+
 static int attach_target(struct cxl_region *cxlr,
 			 struct cxl_endpoint_decoder *cxled, int pos,
 			 unsigned int state)
 {
-	int rc = 0;
-
-	if (state == TASK_INTERRUPTIBLE)
-		rc = down_write_killable(&cxl_region_rwsem);
-	else
-		down_write(&cxl_region_rwsem);
-	if (rc)
-		return rc;
-
-	down_read(&cxl_dpa_rwsem);
-	rc = cxl_region_attach(cxlr, cxled, pos);
-	up_read(&cxl_dpa_rwsem);
-	up_write(&cxl_region_rwsem);
+	int rc = __attach_target(cxlr, cxled, pos, state);
 
-	if (rc)
-		dev_warn(cxled->cxld.dev.parent,
-			"failed to attach %s to %s: %d\n",
-			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
+	if (rc == 0)
+		return 0;
 
+	dev_warn(cxled->cxld.dev.parent, "failed to attach %s to %s: %d\n",
+		 dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
 	return rc;
 }
 
@@ -2516,7 +2480,7 @@ static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/*
-	 * No need to hold cxl_region_rwsem; region parameters are stable
+	 * No need to hold cxl_rwsem.region; region parameters are stable
 	 * within the cxl_region driver.
 	 */
 	region_nid = phys_to_target_node(cxlr->params.res->start);
@@ -2539,7 +2503,7 @@ static int cxl_region_calculate_adistance(struct notifier_block *nb,
 	int region_nid;
 
 	/*
-	 * No need to hold cxl_region_rwsem; region parameters are stable
+	 * No need to hold cxl_rwsem.region; region parameters are stable
 	 * within the cxl_region driver.
 	 */
 	region_nid = phys_to_target_node(cxlr->params.res->start);
@@ -2688,17 +2652,13 @@ static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 	ssize_t rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc)
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
 		return rc;
 
 	if (cxld->region)
-		rc = sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
-	else
-		rc = sysfs_emit(buf, "\n");
-	up_read(&cxl_region_rwsem);
-
-	return rc;
+		return sysfs_emit(buf, "%s\n", dev_name(&cxld->region->dev));
+	return sysfs_emit(buf, "\n");
 }
 DEVICE_ATTR_RO(region);
 
@@ -3037,7 +2997,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	struct device *dev;
 	int i;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	if (p->state != CXL_CONFIG_COMMIT)
 		return -ENXIO;
 
@@ -3049,7 +3009,7 @@ static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	cxlr_pmem->hpa_range.start = p->res->start;
 	cxlr_pmem->hpa_range.end = p->res->end;
 
-	/* Snapshot the region configuration underneath the cxl_region_rwsem */
+	/* Snapshot the region configuration underneath the cxl_rwsem.region */
 	cxlr_pmem->nr_mappings = p->nr_targets;
 	for (i = 0; i < p->nr_targets; i++) {
 		struct cxl_endpoint_decoder *cxled = p->targets[i];
@@ -3126,7 +3086,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	if (p->state != CXL_CONFIG_COMMIT)
 		return ERR_PTR(-ENXIO);
 
@@ -3326,7 +3286,7 @@ static int match_region_by_range(struct device *dev, const void *data)
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
 
-	guard(rwsem_read)(&cxl_region_rwsem);
+	guard(rwsem_read)(&cxl_rwsem.region);
 	if (p->res && p->res->start == r->start && p->res->end == r->end)
 		return 1;
 
@@ -3386,7 +3346,7 @@ static int __construct_region(struct cxl_region *cxlr,
 	struct resource *res;
 	int rc;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
@@ -3522,10 +3482,10 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	attach_target(cxlr, cxled, -1, TASK_UNINTERRUPTIBLE);
 
-	down_read(&cxl_region_rwsem);
-	p = &cxlr->params;
-	attach = p->state == CXL_CONFIG_COMMIT;
-	up_read(&cxl_region_rwsem);
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		p = &cxlr->params;
+		attach = p->state == CXL_CONFIG_COMMIT;
+	}
 
 	if (attach) {
 		/*
@@ -3550,7 +3510,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
 	if (!endpoint)
 		return ~0ULL;
 
-	guard(rwsem_write)(&cxl_region_rwsem);
+	guard(rwsem_write)(&cxl_rwsem.region);
 
 	xa_for_each(&endpoint->regions, index, iter) {
 		struct cxl_region_params *p = &iter->region->params;
@@ -3592,30 +3552,23 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
 	struct cxl_region_params *p = &cxlr->params;
 	int rc;
 
-	rc = down_read_interruptible(&cxl_region_rwsem);
-	if (rc) {
+	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem))) {
 		dev_dbg(&cxlr->dev, "probe interrupted\n");
 		return rc;
 	}
 
 	if (p->state < CXL_CONFIG_COMMIT) {
 		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
 	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
 		dev_err(&cxlr->dev,
 			"failed to activate, re-commit region and retry\n");
-		rc = -ENXIO;
-		goto out;
+		return -ENXIO;
 	}
 
-out:
-	up_read(&cxl_region_rwsem);
-
-	if (rc)
-		return rc;
 	return 0;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3f1695c96abc..50799a681231 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -469,7 +469,7 @@ enum cxl_config_state {
  * @nr_targets: number of targets
  * @cache_size: extended linear cache size if exists, otherwise zero.
  *
- * State transitions are protected by the cxl_region_rwsem
+ * State transitions are protected by cxl_rwsem.region
  */
 struct cxl_region_params {
 	enum cxl_config_state state;
@@ -912,15 +912,4 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 #endif
 
 u16 cxl_gpf_get_dvsec(struct device *dev);
-
-static inline struct rw_semaphore *rwsem_read_intr_acquire(struct rw_semaphore *rwsem)
-{
-	if (down_read_interruptible(rwsem))
-		return NULL;
-
-	return rwsem;
-}
-
-DEFINE_FREE(rwsem_read_release, struct rw_semaphore *, if (_T) up_read(_T))
-
 #endif /* __CXL_H__ */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c810deb88d13..cbafdc12e743 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -244,6 +244,7 @@ DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
 
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
+DEFINE_GUARD_COND(rwsem_write, _kill, down_write_killable(_T), _RET == 0)
 
 /*
  * downgrade write lock to read lock
-- 
2.50.0

