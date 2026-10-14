Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17D469847
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013696; cv=fail; b=uG3QjTaLbFBsWhYPB+JaDBHt5/m1d0HLU8/JERXXOGMJmn2pzmqrd6iub7tI7a8YTNEXNi7ZmTod62i2EGXMywc+FiWIwFKQTM5OOUbvpVxaUaw7gdeYa3oHSSs5FjnlaX7J3cGdo+Jn+Wy5ILJnhAiBnq0Gy1tAN01Kqmkr7ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013696; c=relaxed/simple;
	bh=u1EFgI20KlHhwWsHma51pwQEOnhvwjBoMN+sel7fHv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nG5mTcIIW0wFm7EfpSK8DM+52SOHr/X4pTzhxXwHewOjwfeSSyJrAPdk03Xxc62llEBdyN1BvlZtu8WZi4PW2hd6Fcy9zEdDkEKFcJp9DfsqtpZoFN6wmTHgmiYePLpUkyL5PBiBduOHy/9NUQbtIBGPgBVSzDtHvm8w1GVBLiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzfRPFtc; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzfRPFtc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792013694; x=1823549694;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u1EFgI20KlHhwWsHma51pwQEOnhvwjBoMN+sel7fHv8=;
  b=QzfRPFtcxauacPvHRFQwXJl1psEWJT6kSLY7/onUBtKaxMfQ8siZ2Xga
   X2OQfRMw+/4yefiiy5op39LSFwKj5WusbW0njM+NR5y5jXPl5lRJftTo3
   OlXBO3fiPhv+UEXkB9flVCqV5ntwBR1HkuYlBgJbcvnqwK5Uc65wKlz3V
   bbDetHYWs8GuVUour65xieaAYafz3X6jitpBmEK8gmopkDDdhpskvtfOx
   QKYHkxoaz0VGAthoUbljXle6zsgUx+dvvW0suOIcoobLpHd/nlRvAcEvm
   1tTIH0V1DrxvrIwz5OC8n+cbJQ3dtqWpPjfcklb5r7AsCMEokyoVacTqG
   w==;
X-CSE-ConnectionGUID: JAkaEDIfTBWASymdWFBv3g==
X-CSE-MsgGUID: 1aZj2BJtT5yTIFM6po7lqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="793468"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="793468"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:34:51 -0700
X-CSE-ConnectionGUID: PyiOIB5wTI+ErE6imcOsnw==
X-CSE-MsgGUID: YN9Rw/qCR3qDmhV7YFC9uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1762814"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 14:34:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:34:50 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 14:34:50 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 14:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2OFcptYEWicyyQFdxxwIVtSow8Uc6k3qUfMhTSrdTyTDIz1cI+5zAcC6FLDCUMIXj/ASLvVQnP2ROeANfbZJh1xOIB5cyGOfCzD8rwcXyP490qiLURh84Btt9QLkUgM9xx9hlb5172KvxcV2Walubv35UIM/LrsrWTEs/Dd81CDGBfkZtt0KcwQziHeiO6H5aIwIrLJdtTcjpXTE1cHfnMp6hSL1kaESKP0S5E3cXv83Ztuk2Vhj136Of4uAXaRLMLEoSY6syV7QpscA0E4HlBVc6XPVcUA9Js1l5aiRMRBJGu+VJap/udokbXScR1kVtbgJwGRFPK9Wm27lUqVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0b+nh6bgokTl/8bCNn7GlO65bdv6eL3IHaTUy0Y8ms=;
 b=IQ1Zzcve9/tBVIqHJVhQ/ijyiK4wvtZyJkUVldPRo8pwHYZr3MzM/y1LkI7I3Q/EpPkll4R5W/iKffspUtcq87T0TE/ZqL6bPEPL0apFUvUDHZ13N4DTbJMGGSDA3dZLfdnWnWlGN5wDdhX+ud7jtXim/OGNjMswM69Ud/faqPL635UyBxrKJr1e/yBqOBcM04fslyXPjd5gBn61qx4YPtwYeErMCjR+D+JNsIO0jxue2B5URt8ItlJOuh2RvCRQnpj5ys20iMrVAsqX7qsIhtlf90LcIdV21ALKkCzSft86cWpyOgwG7noZ1ft2BTwRdf9/mrYreTBeUl3h3GvlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB6065.namprd11.prod.outlook.com (2603:10b6:8:60::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 21:34:48 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 21:34:48 +0000
Date: Wed, 14 Oct 2026 14:34:44 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Richard Cheng
	<icheng@nvidia.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/4] Documentation/driver-api/cxl: Add a testing page
Message-ID: <as_1dGrwsPYTlZrp@aschofie-mobl2.lan>
References: <cover.1791949910.git.alison.schofield@intel.com>
 <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7af9e1341a24928799d88adaa6144c1ca82091f7.1791949910.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: 495e52df-ec6b-4d93-2722-08df2a3af8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|10067099003|22082099003|5023799004|4143699003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: sSQKmMcgrNBgeUiDWH4FwCBlW/LU7tpO1iVkkNf3++8CIaV4jzh+s8Nm3mmB7XKeyK8lIOtfrd7BDoHZdWI6fYndw/+ufjI7cd/XPcYe2fZWZKfJy+ph6UMWPBVZWmzopArq0O4f+vh4uNO8piv3EliyCOwUfZdb8/GK8F6SLNES4JNlO5T83zj3tW3NtY5fgJqvoecjq9YMQvJvcOytvvH6+zBrkHUnZgweJF/Y45SM75graMtc4CzDBCsMN11n6zFVMFzK/5F3zY/Ff1slsIsJex56orKmVFZB0vwhwhxSIQVsdabMLWEnuZGxCI5HPmV9Z9gJn7Aqu3vYWo2OgersEvqUgo47qfVFDfiQWix4Y1oCqPhLHBiU3YqAZDZ+6g/c1VyzfTDaRz3wf6kw+ql75Nv8LZ+V1AZNzVIqsCP4tWOi4uFpizc1tBNqt6JAs8QG8D2nuwIQ2iDgV4fIBeQo0OvO6s0mo/Wzy4maPgn99QjBgMxkSJSCSK6V8YqeXwe/jZ6fjqU8PykKMq4BiRTG4VEWDX65JGRYsaYkfd6Hi1rnEkdJ5Sg3F9uJTLQp3ta1AzZFHIX8AP02VBiwVQxkr6sxTe/YKhA6T20l98z6jbnz/Oz1iUqlnti35bq4TWe+wUvDE6dNMH8iFxVV3+P/5eVn1Skfz4IG9pimvkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(5023799004)(4143699003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P6d7dtycYBXDKWlITxxn6Gbszx5Slu57Q5Ov0GUcUt0QE8D4vyXVf1NADZG8?=
 =?us-ascii?Q?Tw34+V8RZkBbEUpEnkhmZZxDH91DLRMeoREW7gnQ3FzZPL/YmH/ySCbbt1FG?=
 =?us-ascii?Q?c24Rf6gcEvAoIeLMYkZEr3LAV8oZwFcEBLY/d+wCZs0TIZtfQIotzyDwKFho?=
 =?us-ascii?Q?d6klLVBa6uXga9VjDoZWHuhV88XIMxOBIp1DBdBFbQrPXo2B7k2DcFVPUABN?=
 =?us-ascii?Q?45+CbE9sAN3DpLWqYZWAJnBXTfrNDJjPE3C0sWDY8Jnl1QBOD0ct4oRnZCt+?=
 =?us-ascii?Q?JtRIQLtYZ95/U14cuv4J/YuyvDHTv0EGzGniB/gS6GdgexLF/mAy8xTBxHpw?=
 =?us-ascii?Q?sfBsLRhReaZ6x37cOoQznO4u3p1OabtH0Inm5nMvAn2RK6K/Sqzwgr4LPuNN?=
 =?us-ascii?Q?B17Yw/yoNFOirwK0XzRkgGKdpa/X5nOexOOgG3fxYBmH7MWEyDqKtUX2q6hw?=
 =?us-ascii?Q?Xp35+Qn7Y2hEpjtYUNVbUrj8nU9ZIRbGjGvYh1lVh4q3fA3gmgp/SjS1M/Er?=
 =?us-ascii?Q?NVAADBNn6eRbk7Q7wW4JSME+LpxB3RggKOZI7nH6IJl5l60q6F37aAcBBsBj?=
 =?us-ascii?Q?wQe3TTbvw4TfNOX7BS950w/Zwwmfd7yiyhDd/7EJ6nKWDnN59sgrVpkR+BgO?=
 =?us-ascii?Q?Yw1G/OYIyrvEuq7k8cdlpsnyklQaYTaEb3A2YFnO4YnbZS1c5z+JeBGQZYGZ?=
 =?us-ascii?Q?h0NPOfV3hs7mOl6QPZpTSEVpdYdBhr1FGaGXYPiMFuXBJRym6GokmQrp/PLv?=
 =?us-ascii?Q?iOtiej3QVa4jZ0iZyjHdYJj+ErwTcDcxZASufNMue//6Y+0x7a5FWfAZR5wm?=
 =?us-ascii?Q?fY6wtH8VazB/5sZG6pvPvGdcMGeYp3tESnWd0b+BAXUFCR0jWtH1HDj0vHX9?=
 =?us-ascii?Q?F4Cwu/JpXBMOkJ2kzmBqqVcJ/BUKoEdiZbj/mPSLAtqG7pfGIFqbOFLVNOa9?=
 =?us-ascii?Q?iZcdq+ws/lsSCbYXtkfaAzadkWfbd9Zo7vAXt4Zl6VnIMdz87Nms2XoVn7ZE?=
 =?us-ascii?Q?LPvgaZz0SoOTG2REMGTzV48Sae8ktwyEp8TNUcTk0g0o8/qfMrL5CR00DpgS?=
 =?us-ascii?Q?V/1BplBMgjRKglgxuwLeSZ2OjWdxwyZSkqvy1+6f36Pwuuy8UKdoknMYh6Jh?=
 =?us-ascii?Q?w4MqZ8Eq4gfrWsPEIfbltIiL3B58q5fOHVh1Vmd+/l4gE1tyqNmywtPHLRvT?=
 =?us-ascii?Q?83d8t/gS3IRWxN1/CPSrkcEYjVWxD0pbLt0PzmS0dpcFrgLwqVkdWDBq8bFu?=
 =?us-ascii?Q?Pcrpy/5qjlZuFfZqBwVLAXF5X7iTkCSms2w9606qR315kh/EKd33QaZwLASS?=
 =?us-ascii?Q?fW/epZCwuAu3yr7JueceiGvQi+SlD9zxM2IiZndZuXdt/05nMLfHzYBF4b3l?=
 =?us-ascii?Q?5R7drZ991uUwy6lot6UNspwE5AUVCNOSPoD2uLoFSS6y7Js45mR0VoJlkB/X?=
 =?us-ascii?Q?E5TO2yiqWQAkiQU9J+aSLz7ZmVnjF3UTw5jn3x9I9edSCtLCNWKgMHVVStUH?=
 =?us-ascii?Q?cSckKQaOXeVPtNFK2Q7WLzVnssRkBOiqbMyXqWUhQXMzl1XXhqh2onqLEk/T?=
 =?us-ascii?Q?vI+Fe8cujUnJ08qxjiHPVc7E/nAjLxSGS5ji0hlLObpwuqUhEetcsUAdytgR?=
 =?us-ascii?Q?DUIDlOTxlvZskJ9gGRfUiRIUGoykNzRNwqrGo1I/lvrpsXTN62QUNEG6FTm6?=
 =?us-ascii?Q?c+37yQ2A+jL/y93uRtZrhRoMMAyjGzZRdrgNI7SUybh1FkWApuwDsW68nz7i?=
 =?us-ascii?Q?O/+AKN7Yv7V1/YZq1BeWOU/WDMk162I=3D?=
X-Exchange-RoutingPolicyChecked: p6vPlCUa4muvhPfmUSv4G4r1ogZbuZlpyN/kplk8GhYX4i4OjCpP9adHLfPhWG1yDKzUDIk0E23aaR4Hwgf3TKq+ZK+rPrXXPXb87dwaofe//qAAtpyIgwd8GmLKhMmzbOoNk/3XPS/qBjtA7BWX16kMHSBrxEPRh2y0M+3MQWqC5XI15bdd3qk3x0pdtPQg++TecPM1hAhNh3MgTjs7DrhxcIwnSUMvXWur/90OOodELBnWJNP/6nzkXPa+3TdsO7/QTQfpJ5JwGkg1DWSNs0ofrupbw7T9KEkXc968L4ONQ8bR5Wczwfa5S9EvTwnjT4vaf6ggbLWAkMjZ2/OK/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 495e52df-ec6b-4d93-2722-08df2a3af8c0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 21:34:48.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB++lMRzOHKeKNvj5ApQ15S7wjFLU1IXbqGawg2K2rNBClqNlRqK2yez5GHVzfwwndayubXH+d0m6o1vGYmSpSyAcIg+Yk/DQHgnBtx8SF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6065
X-OriginatorOrg: intel.com

On Tue, Oct 13, 2026 at 09:17:52PM -0700, Alison Schofield wrote:
> The CXL documentation does not describe the subsystem's testing
> infrastructure or provide guidance on choosing between cxl_test
> and KUnit.
> 
> Add a testing page that describes when to use each framework, how
> to run the tests, and how to add a CXL KUnit test.

Gaobin's question about updating the CMD_CMD_RC_TABLE w the new 4.0
definitions made me realize this doc could use some words around
maintaining the kunit tests, ie keeping them running.

see snippet below...


> +
> +KUnit
> +=====
> +
> +KUnit tests run self-contained logic in the kernel without any CXL topology.
> +KUnit is suited to logic that can be exercised with controlled test inputs,
> +including encode/decode helpers, address translation and interleave calculations,
> +parsers of device- or firmware-supplied data, and mailbox command handling
> +through a stub transport.
> +
> +To run all of the CXL KUnit tests, from the top of the kernel tree::
> +
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
> +
> +This builds a test kernel in .kunit/ using drivers/cxl/.kunitconfig and runs it
> +under User Mode Linux (UML). The running kernel is not modified, and no
> +installation is required. The test kernel runs the tests, reports the results,
> +and exits.
> +
> +Add --arch=x86_64 to run the tests under QEMU instead.
> +
> +Running during development
> +--------------------------
> +
> +kunit.py builds in .kunit/, but kbuild does not allow an out-of-tree build when
> +the source tree already contains an in-tree build. If you build the kernel
> +in-tree, use a separate worktree for KUnit. The worktree contains the committed
> +sources at the selected revision::
> +
> +  git worktree add ../linux-kunit HEAD
> +  cd ../linux-kunit
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl
> +
> +To run a single suite, name it::
> +
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl cxl_core_mbox
> +
> +Enable KASAN when testing memory safety error paths. It can detect an out-of-bounds
> +access even when the resulting value does not cause a test assertion to fail::
> +
> +  ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/cxl \
> +      --arch=x86_64 --kconfig_add CONFIG_KASAN=y
> +

Here's what I think (so far) folks need to know about maintenance-

Maintaining KUnit tests
=======================

Use loop bounds and table sizes from the code under test, such as
ARRAY_SIZE() of a lookup table, so tests adapt as the code evolves.
Derive expected results from the specification, not the implementation,
so tests can detect unintended behavior changes.

When a patch changes behavior covered by a test, update the test in the
same patch. For example, add newly supported encodings to a valid-value
table or adjust the expected errno for a new return code.

A failing test may indicate a regression or a test that needs updating.
Run the CXL KUnit tests throughout development, not just before posting,
to catch either case while making changes.


> +Adding a KUnit test
> +-------------------
> +
> +A CXL KUnit test follows these rules:
> +
> +- Place the test in a tests/ directory beside the code under test, in a
> +  file named <name>_kunit.c.
> +
> +- Derive the module and suite names from the path below drivers/cxl/, excluding
> +  tests/. For example, drivers/cxl/core/tests/port_kunit.c produces module
> +  cxl_core_port_kunit and suite cxl_core_port, while drivers/cxl/tests/port_kunit.c
> +  produces module cxl_port_kunit and suite cxl_port.
> +
> +- Build new suites under CONFIG_CXL_KUNIT_TEST rather than introducing a separate
> +  Kconfig option for each suite. Individual suites can be selected by name with
> +  kunit.py or by loading their module.
> +
> +- If the code under test depends on another configuration option, such as
> +  CONFIG_CXL_REGION, make the test build conditional on that option in tests/Makefile
> +  and enable it in drivers/cxl/.kunitconfig.
> +
> +- Use exported interfaces where possible, importing the CXL symbol namespace as needed.
> +
> +When to add a test
> +==================
> +
> +New or modified self-contained logic should be accompanied by KUnit coverage where
> +practical. Extend an existing suite when possible, or introduce a new one for
> +functionality that is not yet covered.
> +
> +Bug fixes should include regression coverage that reproduces the problem without
> +the fix.
> +
> +Changes to topology-dependent behavior should be covered by cxl_test tests in ndctl.
> +KUnit coverage complements, but does not replace, cxl_test.
> -- 
> 2.37.3
> 
