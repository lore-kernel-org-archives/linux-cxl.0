Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1823F22B8B6;
	Fri, 11 Jul 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277806; cv=fail; b=e2844rhst4gXprXVSevcmTJkTO+k+NVYhhlfOGmfDs0GErpT20eNTOV6B7zlmMGhmeiho62bYw6i6FSxSqAUWf6vFMzlj0n2J5+ixrxd0XyEAes9k19n8DxnbNs6Jb5W+yFABc8GeaapewWy6BkIXtA9Vb4k666qD0vyJM4Wi7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277806; c=relaxed/simple;
	bh=7jkssI0WLE5/1nOusCe0SS70vu9svXghuawwTVwXK4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZGsQA6kgCjPa8rnJDRid5qLDqSWJF5sEnQcFg6yedPM2SoJl0Q2B7TiLZmTA599jkFBxrWayR0LKVQt6y+uja8KrnI4MxRBmJshf4OjxFORBu9qvl6io3dCvfaxx2iimTps5SS66uG44riPp8BPLmgvyBV8klylGVOw+DsjsOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjj0z8Vf; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjj0z8Vf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277806; x=1783813806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7jkssI0WLE5/1nOusCe0SS70vu9svXghuawwTVwXK4o=;
  b=fjj0z8VfPsVqtoBrl1nUrJgbO5wNwIsCQ3iM3cogYdzGR4NZraSoTueq
   4jEqcfQ9vd9pL+1ICdEJKjzCLu3MXtLMy0OuzXS7+PXmnzATxsJIMtJc6
   cDn5EXmJlZP0bB0nzvSKZC7VCeCj1/eQuhlw78k3FpQoFByakHqYBiDjb
   FYy+nKz9/iUTUhOopBQN2t2dQhhgMKBrE0NRBUQ6Owm2ehUNJCXFJD8+G
   2opLhrXi330CWWI/AaN0073D9hQRL4bcS/50491bpegYxG7F57FdA8dxS
   nmFa/I7adf95KVx77FHfkNCqliavK6so+15YkDw46emRcGpmCub3eqSW3
   A==;
X-CSE-ConnectionGUID: Iu6kJVAyRTq0ICrxs2vzNg==
X-CSE-MsgGUID: iwb8wlgfQa2NvYPxre+saQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54448328"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54448328"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:05 -0700
X-CSE-ConnectionGUID: Ll61acF3Q76Xob/mbeU+SQ==
X-CSE-MsgGUID: KUZBST+CRtm1/NnfRlMo6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162160573"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEWtVVlOLK8KmjgjHUDGTcSQYb07h410JxnVD9bsKwv4Z/7YvShqAVV5ksVu5h2J8GmbpZpTdfxlO36i6xQ/U5XmE0hGcACSNqY4furTBX2gVPrHnT2uhe1bw5wrWn4DH8Rqa6gJ3xS2a3QCRZctoAE3pN8Nd9nVnEXOs5JLH0IgwckhNa70j9hxBihWBSkfFHF3G4+DMo952qOcH5LcT6BwiJsoyF8Q+5Nkr8PNXCttJ9BKWT7YXk7cTJaAK+oFtFBI6Pwi1GuYgifZ2c/dNAAfkrDEmnOFC4/qTv9CZS/9E+LC3RDQ68oj1EjGRRnDGjrUEQmH6x7qdw2x+l22cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCur25YlY0Fzx7xlE4Kfh7YCvYP6VdbOliTqow1jKn0=;
 b=I/nyG3Eu53Vh3KyQfy7CNhrHAdl9cN24zA2gMBy0LMjvBm/yBQm1wWdU2LARo5jnjhckVuRhOFWZk6Q1t5VsEmXEUzj3SSHfp1Tbb4ZBW9kqaYQ9ohbaITFoMTcDFX7QpJpk1o5dc9JP8XoLJm4eV5DR9qZGugAno1XbkZkmFzHeHBFemqBJkcu6+TyaDJZmX9eTnEIEoKUYmkGFS8NxHrNd2pb4aCmkLZwUTosy/AwpQyvDYqHX2eMy1EOB6385QwtEk9hJrpL4YW8THinTrzw6/4oGjAUVji5cCchDrOSbz7gSOkxHoQOYHTd9ViQQt1P9svDnB/EQMVUp8q/BUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 23:49:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:38 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 3/8] cxl/decoder: Move decoder register programming to a helper
Date: Fri, 11 Jul 2025 16:49:27 -0700
Message-ID: <20250711234932.671292-4-dan.j.williams@intel.com>
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
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e9f1c9-210f-472d-ec6b-08ddc0d598d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aMANVYNuXU5V+2F2x9tMl1g8G2ku9fVM6IXd/8rG2Dl2rVeFjAVWsxxMklrF?=
 =?us-ascii?Q?gpANTXyRv2v3sMrm3pDZq79tpT+K5worV8+DTE5y3Prjhw+2CMe7ANywNs55?=
 =?us-ascii?Q?S8jQl91XDgc4hZb7Ms1yQSY/ZIuCs0R3JdqQDX3Zbm+gXzGCcRl/jB5GRK+r?=
 =?us-ascii?Q?Kl6INYMB1al541wpJKaIpXKcePLJ5v7oGevj4/Rf++xZfiY7hj6O367/xRRc?=
 =?us-ascii?Q?GN5Y/I9uGpO+Iw3/Y7VPoVS1rxNcMPvCdQRuzLAgHcew18N1SQrrQzcIFiwp?=
 =?us-ascii?Q?/GUbVpBY1HFvUs8FF8wXliGy8EwPHDhCjgIsBgVBOt9duXhffDHViwystsZ8?=
 =?us-ascii?Q?R0DsGY+2QgPdh8h/fzB8lnDu9d0JbEOuL+zXfKxPNfxblLVoPHdtm/tQvjFk?=
 =?us-ascii?Q?Hg8lwsXkRKrMwakZg56ErqCAn0bg5jEYdBEZPDKT5wb4tJkJHLSrunOe79Dn?=
 =?us-ascii?Q?cAARRbf2NRXEtQhbaYRN95s6IFXHxcholWOZxv3cXPfTDpCzM642Rz8Cs02g?=
 =?us-ascii?Q?nD54I/WWW9sVzMrVui5movj9NL45FgG7hVRQ2k/oJagjEaVPVbb3Y7GbUQX9?=
 =?us-ascii?Q?33lMuxp53YCzlU8RqxfKqMzKVkomsXgg+H1q/bZC40kHqexArXDA2Vm2JyO9?=
 =?us-ascii?Q?1PnITuuObNz+eOJnk/yMB8vrHMKvAZ1NLNNJWSOj9JYCGLsNvfE8c04+3LmY?=
 =?us-ascii?Q?wJ4IAbFEYo4wQcfzz6bg1xdL2HFU0l785huPAM98gIhnm/bJITjy3T3uj4WU?=
 =?us-ascii?Q?jbr/tornqY6pjc5klI5U28+RHFC/JzFqIA0Qizn7qWCSN3AkkbeL9U6uJ60b?=
 =?us-ascii?Q?Wtb7FMfPHpTsHfBNk6CdrGwyiC4zPYVIAdrDJ6odJDpV5LKVqjTztW/pR1kV?=
 =?us-ascii?Q?3Fhua1ZLiicwofOkPQ7iq0hcL72uQ9K134Yzsv9To7iBJPdzwrxeOoYsV8tw?=
 =?us-ascii?Q?ei5ML4zx6w5s5/IH9LC3wr95/c4lx3qbUl61cm67kWM9vAuyEeIgrzNeHwZ6?=
 =?us-ascii?Q?CmbqX/KzQoCJDyHBYiDSydn89BVcI8zh3cgkzsiBF6dRnsLkX8YmnKhlXT4q?=
 =?us-ascii?Q?sKbYfP+zB6thewtK/JzLhi05cL94gHgOiQG9Mwv9EFuNpgl+CuloYruhnI/C?=
 =?us-ascii?Q?5mx8qUOy4B0LvwsLRmjmV/gmdquvQbyopLlANnyxzLl1uDb56Y9S5j5FlCLr?=
 =?us-ascii?Q?2UkcI3bbRXNZhYC2oHfAhFN3EpVY9rSOh9zPgrYPBYTOwlMY2pcQfrtTEsoZ?=
 =?us-ascii?Q?JKRx331tG5tXMU9+vcgq0HkkWqS9sp6SVB7BLu1DErJI3z+tTAb5AEGrWdHO?=
 =?us-ascii?Q?5lq80B6VE0fODj6dFYDFhCJcJhmkVg76Q+dOA4dqSl88p9MjyFM75hVvdMR+?=
 =?us-ascii?Q?olTiz7YtDGTezzt6jTKtEp6gLqY4UIyvQ9olFKPHx4cSe+nJrdv8nsPd1a4B?=
 =?us-ascii?Q?Yuy9oEdGQTE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WiNIDG3ZpqxPOdUUD6nszpHHa7i3iw/qq1WOW/ylgW67qu6u6Ra0nHmBpTG7?=
 =?us-ascii?Q?5RhPFuDXZ3XajYie3+sdbYCxHTb2e377neQdVC3m1Zq/2ZyB/HhYCHCvRxnX?=
 =?us-ascii?Q?Y4v8I9WvBt8jCMieJmotyH/UlOkUhK+MqyPv+IEBMSEaTD8URdLSb+a91gzJ?=
 =?us-ascii?Q?BDZcomhXhXPyFwyjsNu5jtM8txzY/+2BOxKPNHljndoZouPbF4ZpPnUSQ1BE?=
 =?us-ascii?Q?dOfePJnRdqo5sdxHXQUQWQN3dBb84ERhBDjtMbZxqLtodKxx3km56Foivdba?=
 =?us-ascii?Q?capfcAcVMKulkM5rKeKhC4+smDMqnufZSvjHLcRJMRDucS15YMfY4Aq41okF?=
 =?us-ascii?Q?U/46Qp+kZq2LlRZHes1P5fRencEyr+CVvc0oYxRn60jXlld+66MRU2Qmoino?=
 =?us-ascii?Q?K5yzBQv+v2XNR+y4Yl88xyFRSvfyCU2RNRvW1J4eU0kqAa1LXW+i/G+Mko17?=
 =?us-ascii?Q?oFIrUQ5Ng/xvThWfYRbLs8tV2wNh58k/0ZVjZKjHq9CO0cCyMBfQKtiKFan9?=
 =?us-ascii?Q?//1oZ/iWmTRGQSyIjJFDo5XVGi5uzyyO3Z79UCLmEo/Uq1qndMWbJP1EEYXA?=
 =?us-ascii?Q?psOI6iT9fIouFuHDbBIyRVIVJB4Qewjg/AnWYajPmZE0QpyGSQSKwt/2MFRl?=
 =?us-ascii?Q?XC3jV/QBjyJGWbyUrS0JUGqe0YizpbwVGTFeYfXi7SMrOGKrYq2FzuF9wN7A?=
 =?us-ascii?Q?aeGtqNuvlxbSxW5b48BI1Zzmci+ZNxr9CYCWi8dsgnGMqltLeJGTCs+UdkD9?=
 =?us-ascii?Q?6URQxoFAGH7WvC65rrmn9OyO47KzDlfCV9cV5wkEh6rHQam0rTpTlFU1rwRE?=
 =?us-ascii?Q?TWEPoMILeZjEy2H5zYe4Sl3PElWMZXoiYHWCSSIKZv40gMLGLZ5bEjm9TdHF?=
 =?us-ascii?Q?S6F+yVNISxnEHj/fCG1zOifYR6VKVFe5/oiPIO4Jnojc7jm3VILX/L1DOxjp?=
 =?us-ascii?Q?Lb6wb43+ObsAbCX0asPato4RiYDkBdX1LX4JdEXsGVcVsCqgq1MpyfIw3g1Z?=
 =?us-ascii?Q?gXTk1vZXpjVZ3fu9UyxjEHanFA3VmAHI9GUjY55engMwBtSmAONpBeg55SLV?=
 =?us-ascii?Q?yKrpMTMqOObhdLi4kEGw/kh7MKSkmq3dEKlwS7BTeSL3VJtWHG0Y7ltO+64n?=
 =?us-ascii?Q?vIh9n6cU8Xa1kBOrW4zlO7MKj318dl1hzbSqiALgvHMSzSOiJNtwpnLI1nw3?=
 =?us-ascii?Q?dxwNtICpAZr3bMfdkSgAYrv5VFCcc9Drfpzerb3qXxAPB8CMSwhIQ9twj0kL?=
 =?us-ascii?Q?/QcIl1/EQp0iKDFvm35io1dL9TdMmOBkgHyG0n3aeN/42y5D2slXNz+qw21o?=
 =?us-ascii?Q?lol79RuCjG/anig27yMOGF63Zx6RiUWTpSXpoQ1YvuaeoMl3qzQqgNrtrWUo?=
 =?us-ascii?Q?/A9fzJWtNxkYCRa2O9hexRcxQYL7RrtOOaRLU/lgpikd7kUpE3oFqarEzhAz?=
 =?us-ascii?Q?vaDS1auH3OhZIcdIf5RUoXq0Yf3DAlXlmerKCrfbcusURrqKwsgHlteTBaqm?=
 =?us-ascii?Q?k/X8uvhDEKa2U4J99ZQYXotb1Vu1yaII0fyvIez9UcT5K6eFoB4MuA0o4gmj?=
 =?us-ascii?Q?rVDGrtm/rjl4sXf3pGm1lETlntohwHnVDYaqFluNd7Z+0H28zeAPCcL87t1C?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e9f1c9-210f-472d-ec6b-08ddc0d598d9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:38.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yOEcnQlTkKxYk5WYwLOSygwOwgFkbSRBYObXexpxJRSYTXSB0hMhniiVnJ/ShIn0QV3xv8iLRWumT1HPJ6Wirl2wZwr7kjYem78JP3von0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 77 +++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..81556d12e9b8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -764,14 +764,53 @@ static int cxld_await_commit(void __iomem *hdm, int id)
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
@@ -804,39 +843,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
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
2.50.0

