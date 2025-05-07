Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDA221263;
	Wed,  7 May 2025 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602615; cv=fail; b=ggnZ9TOmxkHDHSnRFlS7YlbUEXhF4viGwiWEJW3QvFmqLSjgzBG8CqPkKQon86p9icjeWQrsk+Q9WA+oeBwPHaEsHi5meo9JSqRFhPBOvcQl7l6CPFlKg2BdfhLp8E2mXS2Mw4161JAzoPSyg+A2qSQqYypEJhkny79noUD83Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602615; c=relaxed/simple;
	bh=633G7SFOOwrZ6qW2xmvq2A4cO0AKu+cSUzNHkyw/+Ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmqTjvzVxwcGqVCdTL0Hr4zX4o7byyhyiJkhtK3VshAYaXGvn9PrDM3M9FW9A9MV4bYVXJ2FTtusenpA1mI3rSm1X8d1bne1G1VSOYHKeihGUL/5aGXQSvvD4oJhC7ki8U0M7lhYGgsfEq6MgIHtcukWjWtIudI2NzUBtGisDy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfqwfou5; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfqwfou5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746602614; x=1778138614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=633G7SFOOwrZ6qW2xmvq2A4cO0AKu+cSUzNHkyw/+Ww=;
  b=hfqwfou5CUbEy0aY4GnM6jnKVDqUxSn1U1xw7+kkBh3mi9LuxdShzNQ2
   TJfb2WueRAGnDr9p71PIVrYHi+0rnIzpSoUj1MPFSky/r9vNgSXiaBhiW
   1OusKOi7iQXXf35MQmiB/Rsp/qbLOcHeakwMhX+GVObDXPEYNsq2dSN93
   OeWYCw5ZQRrakgp95RKgdfmWYYfW+gRQyZVmTqYQ539rtpLjFDGLY84nr
   t4SMgpixfuyhY6RNotBBsFaQhBuPMA6eaKdHutsQWObNcBRfPazi7LQlM
   ahx53QnDa2D5yPapAz0OjWzEKuTqgtiawwYxhZYKL1JGS2QXUtMWhjW3p
   Q==;
X-CSE-ConnectionGUID: BVgxPbzmRTaRPvE3i5v/7A==
X-CSE-MsgGUID: YdOEKXheTqSrOFeNHDxD7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48450252"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="48450252"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:29 -0700
X-CSE-ConnectionGUID: DqbfcQ7BTK2S9oeVHbq9/g==
X-CSE-MsgGUID: w5XWa2ldTZ27EPfGw3BSLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="173062310"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 00:23:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 00:23:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 00:23:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 00:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czuwRqTzARC+/TPzs5wRbk3hLesUsgAG+qLWGDpXx1LjIkJ8M0pyd+EjNtDDymxHawKFDp8grO9WC89IwNXhuNF6dtFYetJ4MseEk3vm668w9WmlvQwWqHm7WX8blDVu+rHZUQ6gC/SiHhTKeLJrpF8SrbcNB7riVwEPjxGCR1x3sBGeyFLTwdZhaJMzOD071DNoC+tXoSTyMixhJ9nkniE6UkKr/M+6R6YINEG0aJV5RYoQgrekQrWRLjtckCkG6oxSAfSVv6K5/pzRDFV9AHca+fhcuJHoEGWNMD1OTZKJwYSLKoNXeI0lsAiEOqPYvWR8Qt7EQzpWgp9KFvmkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7eq6/5k9fzmKgvdtKZICW+IkOt4ha2Ga0KAK1ePRag=;
 b=Bs884dYmR3NxmkhPnJda61YWrTEXwd3V0ADYf7B8H6xyggdGZRo7X2fTOqAMQEyM12vv5OAEe0U2lSyFKVJspiAS9z/ehFm7tWMMRrhOdjZvZ9pG7NNiCITT3NTek6+Hf2Wbxgs+I6xMPr3h5OZXGnMaGzqu4Q0Yvr0Vg9fe+7YjIWVQbj2EDDiIYq9Tk/GoPkZM004WjxwJ10st1Rb7QNqlYX36OV5aiSx+FRJnvIAxbmwj0B1fCoCkjXGO7eSeaRDjm4lHIryKgsNZhRPaXUENJlP1VrPLvl7SLxTbhTAUzrKpUUcTGg7csTzCedEApoo3p7JzpEWifvL56fLDNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB8270.namprd11.prod.outlook.com (2603:10b6:a03:479::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 7 May
 2025 07:21:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:21:50 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 2/7] cxl/decoder: Move decoder register programming to a helper
Date: Wed, 7 May 2025 00:21:40 -0700
Message-ID: <20250507072145.3614298-3-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507072145.3614298-1-dan.j.williams@intel.com>
References: <20250507072145.3614298-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0313.namprd04.prod.outlook.com
 (2603:10b6:303:82::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 388712ab-90e1-413d-3c2a-08dd8d37d5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RGMIFEWZstoKOcMi5DJAhibNDzYSEpL/hCAosqwvqmONPzrZr1Zc+QpCERyJ?=
 =?us-ascii?Q?0J+zpOluP0A5yK6NcSEvpXpzBIHK5WmoKfBvHInUHDGGVicbowJmeCE0FfJw?=
 =?us-ascii?Q?JkkvYjCtbQFVa0Mr7jjUQ98xz0zAMD9DkzxBmb3q2D6plqlnrDO05i8Gxinz?=
 =?us-ascii?Q?cTkJ6ADh3dtv7Hbfr0FpGfObxGvP/QHMVBpLsyp/opizWzar8JFUvS0lsfON?=
 =?us-ascii?Q?V0HHX0S5G5A0SfsjXOLiRK9CxCLbvfkj4lxwJS6ccMtSkLN5y1oQUeVxnkbS?=
 =?us-ascii?Q?Q2mu5EZJK44/keb/0zK8471fJa5yI9ByhlIXRNJ3Vj3AfM6Phw2tnCBmW16P?=
 =?us-ascii?Q?RWbnjPC7pSTzg/NmQlaRJO1gW72MuRlopW8lDlu+UJuoYc4johjb4hVpSUZF?=
 =?us-ascii?Q?ebefJ/8WQFUL608/n1naWzCbFJzmdvPiEjeTvaevUs/aLT5m17kvK9z6AZFS?=
 =?us-ascii?Q?UVfpDQNkXxfQQMz7uLVEQE5sQ1510eSRr9P3/+Zeq1Zeym+b8B08XakxNgHC?=
 =?us-ascii?Q?jbS8CZmyLFl1uMG3xV4kKjY0m6vmD+UC/b7cfxRDpdPQu7e0ojD/JJYrw8BZ?=
 =?us-ascii?Q?0UPY/HyDH9wzEG6sjryeDYFLdYCTpFFEK9TN6k0/iy1Fo5DeJlnYPDemKfo2?=
 =?us-ascii?Q?/SXXO3qZ1x1sH+Bllh5Al1ROOjHSSMOBFFJ4OM+YXN/G/TxGdTVfLzSp633t?=
 =?us-ascii?Q?Z70npfs7SCgg1FdkzlvFydnbV/5Lj5IiCohmKwEa3iD8HZnCkETnVv0Pqkx5?=
 =?us-ascii?Q?tr6sJc4RxchDKlDdsjNBK9az6cFADzuoLPYM8gLOsKMjoZ92xb81M3jtMp8y?=
 =?us-ascii?Q?VKoNdtU3yKjj5sV6OF9SlHlpQ0XJL3Qli7Cl3wguoGtUX/E80mF6p9FWU1uN?=
 =?us-ascii?Q?Wkhp10alHarJwUH+oxkSVBW2Wd7lbnQ+bJJByugH2wZMN/+nIw3UeWwMFvKq?=
 =?us-ascii?Q?2aEOITvGIIgWry8Vdwnw1Tz9VOTFFmP0ZwIYvVcgXE8aanElSWJaOvb8q4Vc?=
 =?us-ascii?Q?bwbpMPNdk0xc54wcX9nFiEch7lisF90E1tcbYSDLvanFf3CFgyudqZe7qYXm?=
 =?us-ascii?Q?Pn4NE4j7/WnjaM0Bh1C9bomcI6KepT+pYu0f+Uzcj1AK/+D3TB7GhanBfkhg?=
 =?us-ascii?Q?mrUDOvmzuUedmo6YzSy9EzFFxO1sooxgUqg40B1ow0Rudwh0jRtE1mROdPX0?=
 =?us-ascii?Q?O8Gfxm4OwJNU7bd6lfiXFSZpz2MJavAWDkRtpAHKjdfUv4K8uqQNvGk62uf8?=
 =?us-ascii?Q?k3YRnUxLeZiKrDVwGf7CLZU5yoo8lQAKO/JV8z4pv/y6MEanr850VsoJdGl4?=
 =?us-ascii?Q?pKp7Y7Qn7YW8e7S8AYaGWR6lXKqq6pjyKj3kWakDKJ10j4nltmzqdqnBqzdl?=
 =?us-ascii?Q?UfrBsDv+aLDPmYAUm868Y6VQ062cSg7NTqshlpBpTy4iylL6WdppkqvX9QRv?=
 =?us-ascii?Q?92X4YUjJsjc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGHiobW1aY604NJFfdSfJsuQkenXZw/hFSo1pOmexA6Ri9+9/w4oiHGedL93?=
 =?us-ascii?Q?Zrm6Yuro2JUvRZpn+UDl9LrYFMWO6TfG6pe7H7eJviyH4oDDeATaGSuF07MY?=
 =?us-ascii?Q?Akt5eVaxNgizyiSZNevw4k3W9Qo9xl1R6cKwkF7QPw0VHP15x8Kxn3ywId/0?=
 =?us-ascii?Q?0FDFgxIqu+MCpoN6u8jgdXDrzRvVuxMVGjH7hBWYcmveZsnZ65u3mGIXMUbX?=
 =?us-ascii?Q?rhLFsPiebDu7vWQ8DPm7KXLAI2DuWKDCzUnWOunaH/wKVgOLXoxtx6RQR3zp?=
 =?us-ascii?Q?w0MD5z8SBxxeteaJNEik8mkXdIH7+9fxJEIPGMAh4+cbjNsXQsLCDrxXCfWq?=
 =?us-ascii?Q?yJe4gC92EVbLw1BXc43Q4jGJBjFzp8vNzbniuaob37o+CBoJYqiHgjrV/mzL?=
 =?us-ascii?Q?UspTgEzZVYJh/Pi5zuKSos9ZmUNGobmJckB3fX+y/AGAwXmHYCb3whLvBY8X?=
 =?us-ascii?Q?bzY3VMRUpJGm2jDg8XKihSzoxZHCpQYQEwG7XdrIHh1nrsxlKH0LoCi/kMZC?=
 =?us-ascii?Q?JdDFpiRmMaYzE+FlzURScSc8++P+SOsvUECfJMkSZUJBGnoZ7sJRPfi+T1or?=
 =?us-ascii?Q?IgLd45Xg+sftNX9/T3nSY60CQ9MnkqAosNwyP0JVKgVwOJNhTTyHaIq7kerS?=
 =?us-ascii?Q?91DqdZz3WY9NWEhTZrKlfYOHUHKvaSqQFPY6p+xEimDLhkJXG0tuw0dlC9dT?=
 =?us-ascii?Q?ccFEM+ALZGrO9+wkoKxtnJrtP8W3KMia+tu3sy9AdPV2h3GKul+RBytV21hB?=
 =?us-ascii?Q?LjyaArPQi6e+Mlb2shWq+viKR7unI/zwasM/0MWDdYv77nV3P7kEzQuSpLBu?=
 =?us-ascii?Q?T+ioaRhJqwIuVdh5pw0HYavJMIN5pbOhgGbT6zvQqEFow3wa9ECNtZRgnwxu?=
 =?us-ascii?Q?jZe8M7sbKw/F2O9/CH/HkLQ3OsxepnbG8HM7O0CpLeUV+yicBWX8y3BpR7DA?=
 =?us-ascii?Q?5w80ZHWlspu2WMXEk6HTwNkP5MPqHtn30yn5qIXldPHnt0pl6V4A5eOr4LBK?=
 =?us-ascii?Q?Gh/zXnwXwBjeTZ+Jdv8HpHuIWbFemgU9rZYXIeIrGRXCZo+to+sg0W1+Esa8?=
 =?us-ascii?Q?BqX9xHWeQWlhwCXz9hMCE0RHSVLXN+Ddhd4Fi7hLioo1g4zpEKeTAhQUNbo7?=
 =?us-ascii?Q?gyhsTDoux8fjtZfKePfHJ+ZY+KuJvwabhPxzLnmUTHBbywagTHsipP+LDtGk?=
 =?us-ascii?Q?dJuTDl2PGGa6fqKqWinNWBqVECKzkswO+skuw/kd2l0xj2Qmcg6e06xbcorm?=
 =?us-ascii?Q?agMTwHjRdMKiBvzby76Fd/Y2R1qIketLXssJzHugCBn49ti5YOgwO9MnU8jo?=
 =?us-ascii?Q?DiaR5eh0TEnAYHH0Dmu7xbl5KlGV3O0lV+8Vxso74Yx6gQHHXK1Xe9rirOBY?=
 =?us-ascii?Q?ei7KUSgFPCOkt1RHQNS2Zxeml5m/dld2n8UtODiGmCFQpDsY5UXUJqj1Yauf?=
 =?us-ascii?Q?Hxmu8wy7AmMWBAwSJ5DsOwwyiDG9yIBQ2YFh1bgl5oZmviTMwLH6KB56ScKB?=
 =?us-ascii?Q?o9L7fK6mXCqW/jqre+XAzpILox+/ccDGKAHRUTWlXB1tdsOzqzlnLA4XpEy/?=
 =?us-ascii?Q?802E5osL2zU18HrRwLX1SqQG/ZyYnZmsQQaovMXC8p2rOHstaYp2Smwt4Ebo?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 388712ab-90e1-413d-3c2a-08dd8d37d5c8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:21:50.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1nUJ7LAD6yuou30ueGVWVGM4IZBv8bnxUnZcMI2TUcfeULqSAbYR4KxN6XjKW82v0qlRwRR4tVbfp11XWhgK/p58Msx6sptc99M9n6cI6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8270
X-OriginatorOrg: intel.com

In preparation for converting to rw_semaphore_acquire semantics move the
contents of an open-coded {down,up}_read(&cxl_dpa_rwsem) section to a
helper function.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 77 +++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..418539e859e3 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -763,14 +763,53 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 	return -ETIMEDOUT;
 }
 
+static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
+{
+	int id = cxld->id;
+	u64 base, size;
+	u32 ctrl;
+
+	/* common decoder settings */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	cxld_set_interleave(cxld, &ctrl);
+	cxld_set_type(cxld, &ctrl);
+	base = cxld->hpa_range.start;
+	size = range_len(&cxld->hpa_range);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
+		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
+		u64 targets;
+
+		cxlsd_set_targets(cxlsd, &targets);
+		writel(upper_32_bits(targets), tl_hi);
+		writel(lower_32_bits(targets), tl_lo);
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
+		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
+
+		writel(upper_32_bits(cxled->skip), sk_hi);
+		writel(lower_32_bits(cxled->skip), sk_lo);
+	}
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+}
+
 static int cxl_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	int id = cxld->id, rc;
-	u64 base, size;
-	u32 ctrl;
 
 	if (cxld->flags & CXL_DECODER_F_ENABLE)
 		return 0;
@@ -803,39 +842,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	}
 
 	down_read(&cxl_dpa_rwsem);
-	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
-	cxld_set_interleave(cxld, &ctrl);
-	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
-
-	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
-	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
-	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
-
-	if (is_switch_decoder(&cxld->dev)) {
-		struct cxl_switch_decoder *cxlsd =
-			to_cxl_switch_decoder(&cxld->dev);
-		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
-		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
-		u64 targets;
-
-		cxlsd_set_targets(cxlsd, &targets);
-		writel(upper_32_bits(targets), tl_hi);
-		writel(lower_32_bits(targets), tl_lo);
-	} else {
-		struct cxl_endpoint_decoder *cxled =
-			to_cxl_endpoint_decoder(&cxld->dev);
-		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
-		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
-
-		writel(upper_32_bits(cxled->skip), sk_hi);
-		writel(lower_32_bits(cxled->skip), sk_lo);
-	}
-
-	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	setup_hw_decoder(cxld, hdm);
 	up_read(&cxl_dpa_rwsem);
 
 	port->commit_end++;
-- 
2.49.0

