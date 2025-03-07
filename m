Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE95256C67
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741379320; cv=fail; b=Po51jVNxoGqNYLqZMsjAgOgq7eeXOxWJyN+Pqo5lBUCpxmyfZJrtiJKELvwlum55Q1gMD4SulLAOttd8Em6XuHHE9qZu8kZ8GbGdk9WQ1l5g0cWngzmJ8D2542nnPzCD1zJGotQxInHQCYqRwj5WjRduUOEv16DJ2gqq4KbKkcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741379320; c=relaxed/simple;
	bh=yK5bvs3Lwx+BjFLrYuKcQJtD4AxTp714KK0KKqi9zCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KehPyGaACTVR16t13BKYr48ve6gA1kDbQzLaOgIfkk5pulveoSCFVZJeSbKvqRkgTtORthfvOugcYKB930vJyGooOz3bI9X8f8ekWPDEm3MJmT0/Sko8e4RM4gX56dLxp2nlDExi0J6Mq40eYFkiU4JvUP5MfhUvBYHLV5qeD+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LsFARFn7; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LsFARFn7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741379318; x=1772915318;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yK5bvs3Lwx+BjFLrYuKcQJtD4AxTp714KK0KKqi9zCo=;
  b=LsFARFn7+7psdJjhM9ixgmkdfCBhsRLwO7m/cYCQXRieKfCLMcH371Cv
   1TdyEXRo03ehvHAZ7xnTz7E2/mDKF26F3nxRXqCCUHdU0e+BfMjiJZsFw
   ofRdg28ZiO3mBDh9VyudRwYSt7nrYkHsqxlf08HLvKGd/V8saoQqQ8PIv
   qaDLW5nT5NV0QFiObSFqTGSoP1C/xEyWU1/dPDiXSjwLgTPrB8fjJFLA4
   kh63KB4jT2m4xMg+1AYTtBqpVEzP0aJyPVZwhRj7hoatjmVI2idxnurJi
   BCJblrLUMhFCjUiIeDr8/4AfyJEiXPjr2s38cDPcrB21TW8A2Im/BSCg7
   Q==;
X-CSE-ConnectionGUID: ERaiDaRISSKUy9eprtxi4A==
X-CSE-MsgGUID: Ut3LtY3BSv6J0NAJsjLNFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="53429351"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="53429351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 12:28:37 -0800
X-CSE-ConnectionGUID: 3zEjRJFsQGWqAbAU5D8W+Q==
X-CSE-MsgGUID: njLrQdhfQJuUPCYWCY+aUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119167771"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2025 12:28:37 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 7 Mar 2025 12:28:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 12:28:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 12:28:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuQQnDJJWjLcY1szZ1LihbBq7+ZBiqoTh9KYt7PhREnBnlnKk68P1FB2OTPJgkEdEpqsAYDAizicH2/HFrCYYzC7RnuwG+XNpz35OJ6faTY1TI/aXvVmoi7mc1uCuI+dBkbq9V46Qx9eiXlCRNeMpRcL6Q+d/SCtodsZ77CgXatn28XjdCbb8GxAEKrS7bXQ2sgGrB6ztkU4W8t+4XAso4a/5GbkRBr5uzGWUAiz6ysBa/kfuwlL+7RN88Rw+/ATmNiEc+zCNDOcycM78H+EYDPqQMLWo78YhPCgWzIeEqEnFR6MWSuSeAPDePhrTi3MAx5h6FJnFPDX7IRGxNwkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpUyz7IX7zaIUEUPt5gP1twmV23G5Hp3sAEbsoNzz1A=;
 b=eWh4C1ZuhLG32u6WphHSTs+G26U59teKHUusjSFEe5Ah2/SO1SMaUCJVyWn4TFzNVTejcST4Gptp/5U1Jrod6ej9qJ6RvOWog8LLQbcVWIM8aoNLXZcLPWHxaw/cFW0YmQdypBvcU7PGPh5WEyKfU5MRMJlu6LgPuKhHLgFaCTotPWZbmIdHcXSY6A06t3dBObSjIPWdyP8y1HBn/j0Gw+QKRNoYxyojTnyo3RFXz7k6nNfxQ3DWAyxCtgk6fMZCWNoQT59qCcijRq3VsEulGoy6BttDy3oqMQtYKC5rXCMrDvCTbjJ8ZlcQEBmmGWvQoDgqwFCqudo4f/OmnbHopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4833.namprd11.prod.outlook.com (2603:10b6:303:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 20:28:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:28:33 +0000
Date: Fri, 7 Mar 2025 12:28:30 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Fan Ni <nifan.cxl@gmail.com>, <linux-cxl@vger.kernel.org>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <fan.ni@samsung.com>,
	<anisa.su887@gmail.com>
CC: <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>
Subject: Re: [ISSUE]: cxl create region with one memdev fails when we have
 more than one HBs in the cxl topology setup
Message-ID: <67cb56eea05f7_1a7f294a9@dwillia2-xfh.jf.intel.com.notmuch>
References: <Z8tH8BeFQ_WMYs5U@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Z8tH8BeFQ_WMYs5U@debian>
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: a2319440-4d78-4556-d566-08dd5db6a154
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5Ps/zBZkU459Uw3FbpVzvBxuOwJqvQxXpv4oAEN5HLal0o52yoB5Ui/vvaIf?=
 =?us-ascii?Q?KUkKznXqa7UcKBiCBTUrbjX5l6cCsw0V4QH4gdOUOmIVsz/PM67RtZPjzfdE?=
 =?us-ascii?Q?rJbgE2fxnbhLbWeQLUEET22GbvbGUenGaGmfpkLezfhr6SCsP+i1IMNR6Un1?=
 =?us-ascii?Q?p4t01PSfC6IT96OEkuKRwgx7QVxfihu8imUJaPa8pDPoMGL80jOpAaq6k22R?=
 =?us-ascii?Q?cD+DLFlS588J98vY0ErfQpLoFnvvBFK4kWTgJHFDCvGL0BdT7a8uzxtAtfb7?=
 =?us-ascii?Q?LCioSKjGA+gzXH7DEcQdovLrqSbbSEJu/1BgUBa7eA+0JGPmTh3t5Qta52G2?=
 =?us-ascii?Q?SX93yBIBmBVrlU+H+IHV3f9t4j612RoXa1x9rbxTytXVTn1VddlK+9W4S8GA?=
 =?us-ascii?Q?ksc4c50WJK1bTxebvwrb6Rm6uqi/TMtowmRlLKLxnXJp/LZ/tOAwEN5nI8D6?=
 =?us-ascii?Q?08qxHgCmo8Dj9ASZFIaP5PXT8jbw7A+Uy68S4xn664yGfDoMeWp3NrUlOwVx?=
 =?us-ascii?Q?NLsg4ICOEW0I64U5IfYicN7LxgVZg9XO+/p/fsb+iQTXBtpc2RC3QipYvS3b?=
 =?us-ascii?Q?mPvLOWnt7x4q9zYEQWQRwRy4w1f5tKkv45/Mx5XZ9XPZixXQ4YDdsYGhoKb1?=
 =?us-ascii?Q?8Urbhiq2L/M+B7A2pyDOfBzywolz0G88oFjFrziUzLDlSolMRWq641TEBnJD?=
 =?us-ascii?Q?tegfKzNOHufSV5S25DtW8+jTjBggycJqeQKJ8q+JLjuyBzfbDCiZdziViJVb?=
 =?us-ascii?Q?Ah6FEa1BJvLML13eFql8LaB5qEdIwkk0jjLiOG3QvnViTjg4w8XMzUq04xOM?=
 =?us-ascii?Q?41nYcIpaOk4lKfdQxNflEmokDLIJPLQs90XbKIaTELpF8TjxKrvv3Q8s/YSf?=
 =?us-ascii?Q?KsTlMoAxY2MUQa0QdHphuwUO3ogeeiZ71WF7c6mXWxwRWrdweb0KEA9co209?=
 =?us-ascii?Q?KdbUE6sL8AoUONWgXVdbTqZkCtUxCcAsdPZ4CQ4s0xHi3U7Cs67MmHiGD3AD?=
 =?us-ascii?Q?lz6syMjTDzGQq7yWitzhF8yJV68JEXwsl2oj49TXZRb+typb/G3XsdTUgD5p?=
 =?us-ascii?Q?/sdX6Lq5QSVYiqwXrnP39UeEN61a8OZrZegubM9HzY3a80GV5ki6uNeuGBR2?=
 =?us-ascii?Q?H9q1f25s342iZ1kOw0NMIcabzgJOq7hxZkq/qAuPJVt3pRSwT5ICF7aUL8QI?=
 =?us-ascii?Q?bJ7DT/bfpyOjWsKSEDoQXnGiPoAXu+ArfCWU6nVKf+Dlb+zcDBDfwCGXv+F5?=
 =?us-ascii?Q?Yo3GOjbhKs+WpIiGWlj4EFHKL5MELqsWi6CJ9iRjbmqi8CkTiaRuQ5V0N3zM?=
 =?us-ascii?Q?9CwGbxPu8AyEq8J+P+wLo7p7GX/agllYoS8SqrzNmbCK0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gCbRdummzhV8jL/jaYnVRLyRftqvxYSwYQe/8IZ/n4UbmOLQFcrnF0+1c7zz?=
 =?us-ascii?Q?WYVOfnCfC79p0EOWpQdQEeq0u8Fe4NS4WnvOESwZy1cs0ak6+Mb5YAxSaCka?=
 =?us-ascii?Q?/r90mQUs1va3/fNrvdmXW8Ql0l4SePaqauqChXGSajPY+CXbaG0jOLU9dF4u?=
 =?us-ascii?Q?x9DvaZT8CqVRvcwjCB79g80XtNMkg8n8x/OCp9YHA6PI1/osS4GiPAEFVVpS?=
 =?us-ascii?Q?unoI7m9ykM1tAQvYfEcUD1vIh5aEFsajhAasCqmZ+nJPI3sh2IQtOpZVBDKA?=
 =?us-ascii?Q?Kpd09J9nFcuRGKNJdg4VcaAF0rNPuvXayGFZBTeuTw1usV4Myeuil1tyHq7w?=
 =?us-ascii?Q?oYY7wElGxmIK4haVzaG0+9ACtfCLdxTV1s1xDXqWp7q8JkxDSRVVstR0RMOs?=
 =?us-ascii?Q?+iJQkq0OaWKe76KHCjcSOY1pYUhliZCq0jFVaGBNUqVrFZwc50sfwU0mlzEJ?=
 =?us-ascii?Q?fEB8davS9LlDlanzQvZrK4TG2Nm/wVDTxUw4eW6Gr84QTT4hf+Y2qmeszh13?=
 =?us-ascii?Q?4xRhJVlXJHX3RVNx+h7LL35wqyeivFfMz7Cbm4h79xRrqQ5VOy/B7nrkuP0K?=
 =?us-ascii?Q?qLquLoUDVi/eZlTERhz0YuCLJdvsO156RGKcrghwg1QYEbzy2UZH20lJgfiG?=
 =?us-ascii?Q?LxO+YKN1JaUXkodULgru8un4Gt1P0Zck8S/YIIm/bTVrIhC/LRFeKrQyh7Dr?=
 =?us-ascii?Q?HyRb2Rq3BhIFle0UQDxNS+017CgkVb/jvMaA9CuXETqrJb05W+Bq1dng7Vet?=
 =?us-ascii?Q?Fhkr7GjRDhB5n425b1U+NAKv0RhM54hDIqOZyVVJZtqQlWbgv72I51DDp2NU?=
 =?us-ascii?Q?ZUB69aCww+jSKDEQnO6m5VNSft5P5qDIbY1iBNiZ5lGKEMjGJkyatXrRacw2?=
 =?us-ascii?Q?kR6cU6c5PPvcaH3XFiW65F/NoHilCmQbNh2mqHRPpYXkjr8s/lyDhhbppEt7?=
 =?us-ascii?Q?wWFN2dLo8beie9hcIs80f8vODtZGKv15PmSKhUp2yI8TieBwZM9l19fLlS0Z?=
 =?us-ascii?Q?rFGMNZ0r7zHL42nZy//jMOcXW4uZjwuIaqrjqNuibApIetKC61kPWOfi18T9?=
 =?us-ascii?Q?NyXbWR2YLa2pDsPWZswu9DVDwf7GNJtSdP+8HutYziTiTEhNfSirzGytj5ds?=
 =?us-ascii?Q?jCK3OXn3AQgdcOmvyXSP4wIm+V0rcGJc4kUnsAOhiz6EBuXg8FwW5vYkFz35?=
 =?us-ascii?Q?xiB3/hcUm2NqQhcsMi9aHdNXj/UNZ5znGO1UvhuW1EEvHDA2hbh5HCcHewWx?=
 =?us-ascii?Q?d2eZZgS3nFQojjLhXurIlQUTUwVrvVS95/CT3jpqPauHON3BSTehRRrFbxsv?=
 =?us-ascii?Q?2cRYJruSROeOrPSZkTK0QHaK32HoW3jMvFDZYGhsm1CGExO/PgGkMtynWfnL?=
 =?us-ascii?Q?3YnFsaI2WM62EWgGHcIrHjfUKei0aNKagZPHUKVbhYa4qnhKAD/9fTV34u14?=
 =?us-ascii?Q?C/7YOBmmiLs8CvrRquhfwpGs//J7kKicAii31lgG4wlx2BNztPh1iIOyNSnY?=
 =?us-ascii?Q?qGzFjV49qzFb+cZW1xyt7s9XGaLOUyUA2dTAEkuJD5Of7RaLGqyOqqroXquS?=
 =?us-ascii?Q?54AmPHw+VXhhHk1cSDh9RhsiXtomjFw5aznjdhbZdVWZWYz8Gr/rtSEjd8gA?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2319440-4d78-4556-d566-08dd5db6a154
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:28:32.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do8kRTilABHlk0IeVq8kZXzEpnTpZjLxG276ubnc1Lk5r0bTKZKrynz+nAILehNTfneW4F2SLE6C5BXWgYdIgkf+/IBz6ido8odb0LwZfrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4833
X-OriginatorOrg: intel.com

Fan Ni wrote:
> [ISSUE]: Create region with one memdev failed when we have 2 HBs in cxl t=
opology setup
>=20
> I create a cxl topology with 2 HBs like below:
>              CFMW
>            /    \
>         HB0     HB1
>          |       |
>         RP0     RP1
>          |       |
>         pmem    ram
>=20
> qemu command line:
>=20
> /home/fan/cxl/qemu/build/qemu-system-x86_64 -s  -kernel /home/fan/cxl/lin=
ux-fixes//arch/x86/boot/bzImage -append "root=3D/dev/sda rw console=3DttyS0=
,115200 ignore_loglevel nokaslr cxl_acpi.dyndbg=3D+fplm cxl_pci.dyndbg=3D+f=
plm cxl_core.dyndbg=3D+fplm cxl_mem.dyndbg=3D+fplm cxl_pmem.dyndbg=3D+fplm =
cxl_port.dyndbg=3D+fplm cxl_region.dyndbg=3D+fplm cxl_test.dyndbg=3D+fplm c=
xl_mock.dyndbg=3D+fplm cxl_mock_mem.dyndbg=3D+fplm dax.dyndbg=3D+fplm dax_c=
xl.dyndbg=3D+fplm device_dax.dyndbg=3D+fplm" -smp 8 -accel kvm -serial mon:=
stdio  -nographic  -qmp tcp:localhost:4445,server,wait=3Doff -netdev user,i=
d=3Dnetwork0,hostfwd=3Dtcp::2024-:22 -device e1000,netdev=3Dnetwork0  -moni=
tor telnet:127.0.0.1:12346,server,nowait -drive file=3D/home/fan/cxl/images=
/qemu-image.img,index=3D0,media=3Ddisk,format=3Draw -machine q35,cxl=3Don -=
cpu qemu64,mce=3Don -m 8G,maxmem=3D64G,slots=3D8  -virtfs local,path=3D/opt=
/lib/modules,mount_tag=3Dmodshare,security_model=3Dmapped  -virtfs local,pa=
th=3D/home/fan,mount_tag=3Dhomeshare,security_model=3Dmapped -device pxb-cx=
l,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 -device cxl-rp,port=3D13,bus=3Dcxl.1,=
id=3Droot_port13,chassis=3D0,slot=3D2 -object memory-backend-file,id=3Dhmem=
0,share=3Don,mem-path=3D/tmp/host//hmem0.raw,size=3D512M -object memory-bac=
kend-file,id=3Dlsa0,share=3Don,mem-path=3D/tmp/host//lsa0.raw,size=3D2M -de=
vice cxl-type3,bus=3Droot_port13,memdev=3Dhmem0,lsa=3Dlsa0,id=3Dcxl-memdev0=
,sn=3D3840 -device pxb-cxl,bus_nr=3D112,bus=3Dpcie.0,id=3Dcxl.2 -device cxl=
-rp,port=3D14,bus=3Dcxl.2,id=3Droot_port14,chassis=3D0,slot=3D3 -object mem=
ory-backend-file,id=3Dhmem1,share=3Don,mem-path=3D/tmp/host//hmem1.raw,size=
=3D512M -device cxl-type3,bus=3Droot_port14,volatile-memdev=3Dhmem1,id=3Dcx=
l-vmemdev1,sn=3D3841 -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.targets.1=3Dc=
xl.2,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleave-granularity=3D8K=20
>=20
>=20
> -----------------
> # cxl create-region -m -d decoder0.0 -w 1 mem1 -s 512M -t pmem
> cxl region: create_region: region0: set_interleave_ways failed: Invalid a=
rgument
> cxl region: cmd_create_region: created 0 regions
> -----------------
>=20
> The reason is for the root decoder, iw =3D 2, while for creating the regi=
on as
> above, number of ways is 1, which fails the check here:
>=20
> https://web.git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/tree/driv=
ers/cxl/core/region.c?h=3Dfixes#n491
>=20
> -----------------
> 	if (!is_power_of_2(val / cxld->interleave_ways) ||
> 	    (val % cxld->interleave_ways)) {
> 		dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
> 		return -EINVAL;
> 	}
> -----------------
> 491		if (!is_power_of_2(val / cxld->interleave_ways) ||
> (gdb) n
> 493			dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
> (gdb) p val
> $8 =3D 1
> (gdb) p cxld->interleave_ways
> $9 =3D 2
>=20
> So how can we create a region with only one memdev when there are more th=
an 1 HBs,
> but we only want to touch device under one HB?

Then you would need a new CFMWS entry to allow that. On hardware
platforms with multiple host bridges you will see a set like this
following for a 2 host bridge platform with RAM + PMEM support:

CFMWS0: HB0, IW =3D 1, RAM
CFMWS1: HB1, IW =3D 1, RAM
CFMWS2: HB0, IW =3D 1, PMEM
CFMWS3: HB1, IW =3D 1, PMEM
CFMWS4: HB0 + HB1, IW =3D 2, RAM
CFMWS5: HB0 + HB1, IW =3D 2, PMEM

So, in this case it looks like your CFMWS set ("decoders:root0") only
includes something like CFMWS5, so you need to update QEMU to produce
one or more of CFMWS[0-3] windows.

[..]
>     "decoders:root0":[
>       {
>         "decoder":"decoder0.0",
>         "resource":79725330432,
>         "size":4294967296,
>         "interleave_ways":2,
>         "interleave_granularity":8192,
>         "max_available_extent":4294967296,
>         "pmem_capable":true,
>         "volatile_capable":true,
>         "accelmem_capable":true,
>         "qos_class":0,
>         "nr_targets":2,
>         "targets":[
>           {
>             "target":"pci0000:70",
>             "alias":"ACPI0016:00",
>             "position":1,
>             "id":112
>           },
>           {
>             "target":"pci0000:0c",
>             "alias":"ACPI0016:01",
>             "position":0,
>             "id":12
>           }
>         ]
>       }
>     ]
