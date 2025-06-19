Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC730241103;
	Thu, 19 Jun 2025 05:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750309480; cv=fail; b=DCiwLfydH6h+598zDl2tFX7SbtW0wMtKC4TaAMzajNDUctiiMusQMUcUlH8X28NdpICy1htPTfK9eEqVv52o9vu61pJBxzcav8295JL4m7i0fGmXZSBg4C04o/+IkNbKKFScnl4vTY+EGCgwM+cINy5EG1EH/Bt2NubzTMVpMEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750309480; c=relaxed/simple;
	bh=lGx23sa4dgcbEFJU3dNS6asTd+F3QdIdHgVDwVZLaWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOXtofULiytpk5R+J7JjDIkNtMqzPkktGLdipEHD+NYMv7jPq3Cqal+L0YJ4tf+yuGk8s3mG+n3570QGpODoXB/8Id3tEV2irfIb5tEy8y/6SYMU41E0BII+6lSORZ+//BMFM7CS87yK67fAdTGuV4IaWt4bdgbYVBfwmqWNVRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yk+E2YKZ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yk+E2YKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750309479; x=1781845479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lGx23sa4dgcbEFJU3dNS6asTd+F3QdIdHgVDwVZLaWE=;
  b=Yk+E2YKZZUEDCwhm7gpyEpMrlSp2pO6iwu1U8UVLVd+cZRDOFtIQJXjm
   hvbGisbOy7L9kvDsD0tx2w/bKK5tWFq7MQJpaTjALxAa7aO2g7qvIK3f6
   Ad4v6UH1fX5DUgUF+gQ8JNAm9/I/zgvOJzlTkbjrO/g3N/RYaUfPUmMc+
   4BCG+lPIdaDOAngshY7HXHJJUsH8KRYKOy4Q3B09GBDhv2xotbFsR/9Iy
   FOegDF4UniMW1tt5yZXTTeDyb1GDlr7lIr8TAQoYHX2p/MOdh+zxaO9J0
   r+dByIMxy5iWb9fwlxYXcPSRLC6G9rBaC8/Hx1MHmhtqwxotrUj6jB41m
   Q==;
X-CSE-ConnectionGUID: gQ4BGfrUQBe7ApddO8r2/g==
X-CSE-MsgGUID: MS2jvy01SqSEsdxXtBrXTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52702174"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52702174"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:33 -0700
X-CSE-ConnectionGUID: yJh9MACsQwSCvD6gv7OakA==
X-CSE-MsgGUID: Ld4czjJfQUCfkgWMv0dfbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="154413081"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 22:04:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 22:04:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.42)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 22:04:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P72D9iox+lsi4dbOdASdDK0GHg+oNJJcIZZcpj8tTbl54nj4iCsabygxRoNmydm5qT688awv7gc6SlaaJfjyD/MwoY1iXq4o8zLtzJNNooyWrjb2xHM415VFZOQh2fz3WSO4FxrJo5XApVqvXcsaLDErWkJjZPh6cBZ9Bq2PoJuZU7Ay0tu8yBoZlcD4yGgGUdehhtdQLXAV1GmGeGoj+8UIIFNJ7/Tb+BsVMRMSxR0XxwbtXCKL3T62CRsptskwQ4jLIwdwg7vGQu+smTcvy7ii/1LqSGN9gNPfgkQI2XFaS+QQaTbRj0yr5xNGkU/ksO6D9Tmm1YIJUWNR1Hg4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DsQ0+ZAlz19dLGpyg44jSj5AjV3lshEy3BWhPAi3K8=;
 b=CJHTeix6aPfV+JkSPJB+wzZepJ6CiJFL8DXcrH2Z3H3e+XHazU4gLv/ffSYY1IZgWD32FjN2KMqQDO4YVfRsjoA9hAsQLJrdo1EwPOHb+Gzl4araNP4LvRy6XoHVjAIKZt1LG4243VdW9fyHyea73ITiEXLIoyE/Po7jqBVM85f2gvRYEsotZCkAB474aeQwy18twBevG8aNbaCILgo29D6jd7BPI+uVd9mfJssCAbQAUcUrI7aMFrOV/n3vTm+SH0fcMRsN2LGFKx78vAoFaCNJpfdetP3xY7DOzaVebgC6inI/e28x2cYJTuKkbPQLH6qE+rKZGkgVZwW8NJB5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB6819.namprd11.prod.outlook.com (2603:10b6:930:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 05:04:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 05:04:21 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, David Lechner <dlechner@baylibre.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2 1/8] cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks
Date: Wed, 18 Jun 2025 22:04:09 -0700
Message-ID: <20250619050416.782871-2-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619050416.782871-1-dan.j.williams@intel.com>
References: <20250619050416.782871-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:a03:338::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4fa96e-f41e-4c57-e68d-08ddaeeec040
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tac7vZtefFy4kG2pH6E0e1lQSOrUFfKTv8V51xSCI9NVTexBi7e4eu6cD2k4?=
 =?us-ascii?Q?T1yRKT30PYRamKwE49lU2QSkS5HZTlF3zHECPaCONVlN5Kf/shSpFZ9U2rsh?=
 =?us-ascii?Q?nRRlFMZPxRUvap4yEMYnVys4ZgSsW+4xiPOlp/yhO9//G6qquuh7WfLlkVgc?=
 =?us-ascii?Q?a+4cc7LMFgAwIJdH6s7168iB9ReAVOIwUCKD5GYw4HMt/k5jtsXpdtJP+kOE?=
 =?us-ascii?Q?so5V4NC0se7q5ES00wbTKqJnNGj0kyXyHTCOf7ogleVMm1e4XpCPKeIaaIzi?=
 =?us-ascii?Q?7opCLDLyVWFDk3apUHK/y+OERWhEoKM1+4j8sfzUjCy70KPDSgbLon3gbLuP?=
 =?us-ascii?Q?CgncFMS6v0rlfKbxADYRR1uo+ylJriXqICDdWiAj7sWw03YtcwQFnrzA6ZaF?=
 =?us-ascii?Q?DuFJ+wgNa5LhbRQQES9xtfltPCNGBNaH6z/4gQKUCHkD+BT0wcsLQ9KMFZFq?=
 =?us-ascii?Q?2+1hj8CEgpLScpi/LaGgCo2oZsssNaSdQZLf1A2UEHRGWZIoS+3EstTGuETa?=
 =?us-ascii?Q?7U/dsa9VhN9aLpR5butpR+s96j5P8b71ECj5zryyyVgDTnNhuhKhSIPJMrj6?=
 =?us-ascii?Q?VvL3Kt+iqHLVhvkhvVe3IvmkkXACyhtR2rOnAt0IwqIx8qKebJS9e0342mnR?=
 =?us-ascii?Q?sAgSNALfrisxT5LmzCrk1VKvJ6TZpxvebMhDaUGBS0Dr8U+yAH5honm0KhLt?=
 =?us-ascii?Q?wxWb84ufYnlr2lijaSaNlKPq4PUAHpP3pE8Gx9vVA0ybBWsPchn5JRzvuuRp?=
 =?us-ascii?Q?xgNGj5s9Bq6oGzyfecLbnH0vHWpnJ76mJbSnAPpjEpnWsKgDgLBd9/q+T8p7?=
 =?us-ascii?Q?lOUQ30GXEtNV+ffSUUrMokIudFx4BZK+j7nXTAnT90v7kD/5YG5MyAdAQlSt?=
 =?us-ascii?Q?wDPaDnH3oGPyWssE4rAbHEGg5XJaR/2Ych0w1HXcjqFoikEHEjtZlDZTxGb+?=
 =?us-ascii?Q?Wl2tek/wxQ7EhZKpmrSSQDVkjccfGweLzu7dv9bJwKMu0vclv4HNFh/5Lcot?=
 =?us-ascii?Q?2bdLgvYtWjTGNmheaZIfaC0aQ0tml4FEZ75lZU2kPUF0S/S78Q47c0FJwoWL?=
 =?us-ascii?Q?n8Qq8+Gu8se2iNRVbPoIK3DmshCSw3ZmdLeSo3CGieU/aF92akE+NIM/jEYT?=
 =?us-ascii?Q?rocHKFQ4yK6vxTNQfK1Yhj0knuysbfngISREZ3DPiFBOefxuI/+i5HQfVltu?=
 =?us-ascii?Q?2ld/xX0yUoTsU0S63va7fO3CUcmtfQJYX7NpUi5JtDSW6BRQSVDs0ZzuztSs?=
 =?us-ascii?Q?XDYewfoE7gb3rY3KCIxQqmpYUSBUWCQ5qEFuZyMmNiOg/meNeo9mdbxrBfWt?=
 =?us-ascii?Q?wnUdubtTfnHKSQnKg3+42j4e16xD74tERMEgg9yZziRZjsrYU7G/fb8fFSPM?=
 =?us-ascii?Q?AZMkPGMF26UV6h/gI8uQ5eOOAV1F?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GlN7Hp9t5kXzvZRSezghbJURrNJXBgoweVcT0HM2FwnqrGIgwGEv/TlbB1iq?=
 =?us-ascii?Q?pkQ/k6iqIXh2zf86/nt36vGBhJFdCr2ncrHSwg8JXNVAnTpfeP0X+dJaeIye?=
 =?us-ascii?Q?+dR/2A2WCjCSB5QCEyEpUHj6JpJQe3+GbLJMPraTMPlSU9Kjsg1rS/BlXUom?=
 =?us-ascii?Q?OzGN9WkHytgShuGSRNMXwJHZd5ntdrlQCzuh0iik3otuKHlosF/7IycPxSJV?=
 =?us-ascii?Q?0Fb1Ct4AC+u+w4CNlUJVLzXVM8iuGxWadkSipYjUXZtZzq4rbxrKV4zwp7fh?=
 =?us-ascii?Q?i+uJo0uGbdLi0XQdTa07M9X+KZ0eZRCi+00QVTGhSjyB7fvRNQMP29HLL51b?=
 =?us-ascii?Q?KC/aBLkvEnuF1/5gkpeL59ezGlTky7keCvnXRy9fmjWG3XQByOJ9Lj8cv6+M?=
 =?us-ascii?Q?R53RA8SeLniiqGteeKftaLQpN1LKq//nmXViu2pjcY7p9/VtX79JQQeqvsRf?=
 =?us-ascii?Q?5FDHgOfN1e0+bjoQu3Sk56KsQ+DPEHwt4JZbWRCpQSTfCtCBTf8PMFdxyMzJ?=
 =?us-ascii?Q?fHb1gx/o82Y8pfbi1MyWQbmOrFlgig/rFPfkya4hVlvZsxx1pmcB6B3EbgYu?=
 =?us-ascii?Q?VrVQf3tioL3adMWvW5Jd4RIb6uMdpWg50KxA2ELuuvgyID4IzkGh4HRfSWac?=
 =?us-ascii?Q?6LwAmYyhD/lUUZ1bM0kQzd2jEl1f9EYuTFDTafbyKY+HnmSK31H1oHuyEkj4?=
 =?us-ascii?Q?D34OaCNSwqm1AVk17lzdqnobEtCmO6LCSI/k7RzU8LTfIgIu+Sx0xWtG1q/6?=
 =?us-ascii?Q?1eviiyCHOfmNeimZHhN05WPU5BRYdFBzBvNBxFj2HaU8c2lt6lca7dA9yBPD?=
 =?us-ascii?Q?khqbRkMr7IGc2hiKnw0lynvvaVquT52ra/zeZaeUatcsKah5vSfnO4oO7lba?=
 =?us-ascii?Q?J9Qt5rOdpNDonfkKKzQCSNCr0hOcDo3Jmk+K/1yEbTGd0aQoR/VGc6bsMJEW?=
 =?us-ascii?Q?jKy+v8VOXS8yFIzbiqsFeBExWq8zFMqkFNOiiwxVrfmczQYVd+PAjuUqG7eP?=
 =?us-ascii?Q?41LuAr7+Ez07mSyDRXq3iHynCUXhtpBtWWc9qJv6QQ/kKswmiy8jgzmXXAL2?=
 =?us-ascii?Q?XF1WpG0eykE5k75BF0MDIXST6DMuH0bE+W25AGK5jveuKKSbq5+Bb/YC7/BU?=
 =?us-ascii?Q?SP7t+/+2F6TkhOqnD83TaRmp4OtBwKw8jegugL89ZIOe07mERLvbAkpmWV83?=
 =?us-ascii?Q?b9RDBqtIfdWZcSUM2BIDKbGPBNObZtqvFS7o1+aVLVsjdoheuYbjguGAjvqC?=
 =?us-ascii?Q?JbjWNjIA3IVeoMYz941b4d38a3diYpMv3fQQx+jPBoP0xj3DvB3fFDHWzJGw?=
 =?us-ascii?Q?SbarCN5H0U8DKYVQ97URv/M0xB23M/W7VV8KxhMd8hCSkBGT793CquyOE23e?=
 =?us-ascii?Q?uQxl1y7zdcnRgEJFhrJMEBer6a7x5JsylINbeEnb/QXp8wE9BCawytHt+YXA?=
 =?us-ascii?Q?/xlZMJJHqkFVOgQVvJtxFc1ETZMJRW0psZW4xQkN7ZxS/uVJ2jTGL1bUuLPY?=
 =?us-ascii?Q?ZdFhkUHA+2VhBWLMt9JXMoUqU7i+sWJLiO2NMh6lGqZfphLfoRRYUqazYHiS?=
 =?us-ascii?Q?kSzKOuAgFEJrHmZ/39lTke7Ba7iNafm8gz8j6F3HSF8fcZvwOca43XFo/cY7?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4fa96e-f41e-4c57-e68d-08ddaeeec040
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:04:20.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phqyNyasMpm5DgpWqlqCLkbvCkWvuhMvqyHxp6sH1fRbsKD/1kj2IoPGxINmUGSYY4/A7O6G78GAgc/I1yhe3euzpS60Brkq1EEd5Ha3yuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6819
X-OriginatorOrg: intel.com

From: Peter Zijlstra <peterz@infradead.org>

scoped_cond_guard(), automatic cleanup for conditional locks, has a couple
pain points:

* It causes existing straight-line code to be re-indented into a new
  bracketed scope. While this can be mitigated by a new helper function
  to contain the scope, that is not always a comfortable conversion.

* The return code from the conditional lock is tossed in favor of a scheme
  to pass a 'return err;' statement to the macro.

Other attempts to clean this up, to behave more like guard() [1], got hung
up trying to both establish and evaluate the conditional lock in one
statement.

ACQUIRE() solves this by reflecting the result of the condition in the
automatic variable established by the lock CLASS(). The result is
separately retrieved with the ACQUIRE_ERR() helper, effectively a PTR_ERR()
operation.

Link: http://lore.kernel.org/all/Z1LBnX9TpZLR5Dkf@gmail.com [1]
Link: http://patch.msgid.link/20250512105026.GP4439@noisy.programming.kicks-ass.net
Link: http://patch.msgid.link/20250512185817.GA1808@noisy.programming.kicks-ass.net
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
[djbw: wrap Peter's proposal with changelog and comments]
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/cleanup.h | 77 ++++++++++++++++++++++++++++++++++-------
 include/linux/mutex.h   |  2 +-
 include/linux/rwsem.h   |  2 +-
 3 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7093e1d08af0..1e1eb35cc225 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -3,6 +3,8 @@
 #define _LINUX_CLEANUP_H
 
 #include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/args.h>
 
 /**
  * DOC: scope-based cleanup helpers
@@ -61,9 +63,21 @@
  * Observe the lock is held for the remainder of the "if ()" block not
  * the remainder of "func()".
  *
- * Now, when a function uses both __free() and guard(), or multiple
- * instances of __free(), the LIFO order of variable definition order
- * matters. GCC documentation says:
+ * The ACQUIRE() macro can be used in all places that guard() can be
+ * used and additionally support conditional locks
+ *
+ *
+ *	DEFINE_GUARD_COND(pci_dev, _try, pci_dev_trylock(_T))
+ *	...
+ *	ACQUIRE(pci_dev_try, lock)(dev);
+ *	rc = ACQUIRE_ERR(pci_dev_try, &lock);
+ *	if (rc)
+ *		return rc;
+ *	// @lock is held
+ *
+ * Now, when a function uses both __free() and guard()/ACQUIRE(), or
+ * multiple instances of __free(), the LIFO order of variable definition
+ * order matters. GCC documentation says:
  *
  * "When multiple variables in the same scope have cleanup attributes,
  * at exit from the scope their associated cleanup functions are run in
@@ -305,14 +319,32 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
  *      acquire fails.
  *
  *      Only for conditional locks.
+ *
+ * ACQUIRE(name, var):
+ *	a named instance of the (guard) class, suitable for conditional
+ *	locks when paired with ACQUIRE_ERR().
+ *
+ * ACQUIRE_ERR(name, &var):
+ *	a helper that is effectively a PTR_ERR() conversion of the guard
+ *	pointer. Returns 0 when the lock was acquired and a negative
+ *	error code otherwise.
  */
 
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
+#define __GUARD_IS_ERR(_ptr) \
+	({ unsigned long _rc = (__force unsigned long)(_ptr); \
+	   unlikely((_rc-1) >= -MAX_ERRNO-1); })
+
 #define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
 	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return (void *)(__force unsigned long)*(_exp); }
+	{ void *_ptr = (void *)(__force unsigned long)*(_exp); \
+	  if (IS_ERR(_ptr)) { _ptr = NULL; } return _ptr; } \
+	static inline int class_##_name##_lock_err(class_##_name##_t *_T) \
+	{ long _rc = (__force unsigned long)*(_exp); \
+	  if (!_rc) { _rc = -EBUSY; } if (!IS_ERR_VALUE(_rc)) { _rc = 0; } \
+	  return _rc; }
 
 #define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
@@ -323,23 +355,37 @@ static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 	__DEFINE_GUARD_LOCK_PTR(_name, _T)
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	DEFINE_CLASS(_name, _type, if (!__GUARD_IS_ERR(_T)) { _unlock; }, ({ _lock; _T; }), _type _T); \
 	DEFINE_CLASS_IS_GUARD(_name)
 
-#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+#define DEFINE_GUARD_COND_4(_name, _ext, _lock, _cond) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
 	EXTEND_CLASS(_name, _ext, \
-		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
+		     ({ void *_t = _T; int _RET = (_lock); if (_T && !(_cond)) _t = ERR_PTR(_RET); _t; }), \
 		     class_##_name##_t _T) \
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
-	{ return class_##_name##_lock_ptr(_T); }
+	{ return class_##_name##_lock_ptr(_T); } \
+	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_err(_T); }
+
+/*
+ * Default binary condition; success on 'true'.
+ */
+#define DEFINE_GUARD_COND_3(_name, _ext, _lock) \
+	DEFINE_GUARD_COND_4(_name, _ext, _lock, _RET)
+
+#define DEFINE_GUARD_COND(X...) CONCATENATE(DEFINE_GUARD_COND_, COUNT_ARGS(X))(X)
 
 #define guard(_name) \
 	CLASS(_name, __UNIQUE_ID(guard))
 
 #define __guard_ptr(_name) class_##_name##_lock_ptr
+#define __guard_err(_name) class_##_name##_lock_err
 #define __is_cond_ptr(_name) class_##_name##_is_conditional
 
+#define ACQUIRE(_name, _var)     CLASS(_name, _var)
+#define ACQUIRE_ERR(_name, _var) __guard_err(_name)(_var)
+
 /*
  * Helper macro for scoped_guard().
  *
@@ -401,7 +447,7 @@ typedef struct {							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
-	if (_T->lock) { _unlock; }					\
+	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
 									\
 __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
@@ -433,15 +479,22 @@ __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
-#define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+#define DEFINE_LOCK_GUARD_1_COND_4(_name, _ext, _lock, _cond)		\
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true);		\
 	EXTEND_CLASS(_name, _ext,					\
 		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
-		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
+		        int _RET = (_lock);                             \
+		        if (_T->lock && !(_cond)) _T->lock = ERR_PTR(_RET);\
 			_t; }),						\
 		     typeof_member(class_##_name##_t, lock) l)		\
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
-	{ return class_##_name##_lock_ptr(_T); }
+	{ return class_##_name##_lock_ptr(_T); } \
+	static inline int class_##_name##_ext##_lock_err(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_err(_T); }
+
+#define DEFINE_LOCK_GUARD_1_COND_3(_name, _ext, _lock) \
+	DEFINE_LOCK_GUARD_1_COND_4(_name, _ext, _lock, _RET)
 
+#define DEFINE_LOCK_GUARD_1_COND(X...) CONCATENATE(DEFINE_LOCK_GUARD_1_COND_, COUNT_ARGS(X))(X)
 
 #endif /* _LINUX_CLEANUP_H */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a039fa8c1780..9d5d7ed5c101 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -224,7 +224,7 @@ extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
 DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
-DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T), _RET == 0)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index c8b543d428b0..c810deb88d13 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -240,7 +240,7 @@ extern void up_write(struct rw_semaphore *sem);
 
 DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
 DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
-DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
+DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
 
 DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
 DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
-- 
2.49.0

