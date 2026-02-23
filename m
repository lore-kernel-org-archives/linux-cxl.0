Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C237882A
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881961; cv=fail; b=evM4NFsKeeM7+LnXVmAELPq3cW+NwUh+8uG6llJuDekdWdztWNk1wvJw44A2FngPQLK3bKhFaecbSZYCOFPINyG5LDXbdnuhUwHTWQwC2hzWBo1YDKSPZWNM8ULe6orWFfAEzKDrsn8lPJ3UePiAiebg1XcG6p5xBL/tcM50PeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881961; c=relaxed/simple;
	bh=p5Em64SYI9ZtJDdkm99EWsg2PTB/8IQ2uNvhPIGppso=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G/DL7l1waftpymx5P6M2lnWq431Q1JLJ/BpVcU3HKycg4LFyc1ybi7MkNvYoNyujFtHXce5LRDrzOwShul4mCcZiYPz3DYe3USxNB6I52ZNpouSaAK21BjuifPRLzqN1QTFkTBfBZvVuRM5f0JnkyN0ktSKK67G8AbMX0n/GLTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx7/DC3d; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx7/DC3d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771881958; x=1803417958;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=p5Em64SYI9ZtJDdkm99EWsg2PTB/8IQ2uNvhPIGppso=;
  b=jx7/DC3dsBMYjT8hJUVksE4Jf58z5K4UpmhERnezv7OByhx4PVVdGEHO
   0XMpQRRZV/tu7gqd3/IzzgcTGDQjGOCOavsqy7sIv43DxZq+lo3ypeql8
   zUApzsiQbzUtkUu2ZSYYyOAcwRW0Klc4ZT35B5hYk7bVwEoN0Km+zTAso
   POJKUQSyCYwi/LW4qXKusOCzmi9V5tZaNtZihchF9LGkSqKzvnp+Er2o5
   a++JKczs5nb6qx5MOM7c4IEFLXJwF6wlludcz7ngoJznHAHW2vWUAkDlS
   trATFJXXqL5PhTw5/RPJohfHUZfUkzLLiOxwN3J93Arw/+7DfMP5jND9O
   A==;
X-CSE-ConnectionGUID: Y7j69gVRTOuqOQS4GOwLfg==
X-CSE-MsgGUID: HTC4uddFQSKh7+H3plbOOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="84341282"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="84341282"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 13:25:57 -0800
X-CSE-ConnectionGUID: 76lzVRHjQgO6FZhIizgkpg==
X-CSE-MsgGUID: OGPxFSAGR5GtHLcDXcbs2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="253409460"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 13:25:58 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 13:25:57 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 13:25:57 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 13:25:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzXhvnfrwQvb4+yINTTyA2kZwlB9PlWlJ6Dj5FCO45KegOFSUWkZ10TkM3aZtqCyXAvNbeMAVLjZkRzFg+L4YYhp9/SW6mSTrpdesBxnsvV3ddRFGHtBqM00t/0NqW7y/tFAZ6ykn+Zzl6xNKMsou/qswDRbLfp7GYkJI7J+n9jxM44RDXgwgxf9N8fOJ5rHosLHacxE8Fbc5Un5fGKMnAiw7h90FmEQtY77/30lynXmEor4Gt4owSJ6Ahf1Xg0xFiygPtuqetaB9H9n9U+Gi1J5igA4gaNAS3umfBEzMkBwyPIikfo8kV+v5ivS2i4CTc3CY5srarEsHQ4WCxcDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+je06UernDyVv5cmbUzsyGmJ/ZOXcm1oMHg6Du8JgY=;
 b=Dpc8YkIQ1uSsui/Di/bKzediptUCi6RnHj6kXTju7hNfOEeQAXCYDK6YR8xQvGL3JfrDGRFjgzvkB25qA7ChxFW9hltpklT6TX2xlab5mNymfFRutwh5gjTs6mEn5sR0BcQUW6TG+rzGouYA5YurdD92hdJ7rS6zqXLldyPqkqbmigYEGu5jZN36DczPIuTjTq3JMcsah8RSN9KbdoormRw/SEAguWnsJUYQfrITlp+bTY2/mhil5VCtF7NCMFud6d+DetnbGcbAIJ3RTpqZ5gzGz0PVR3XWjmvxH5Qd9H1voipZSfc1+dw3dV5X6h1XgWUyE/cCx1QWoOx77U42MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SN7PR11MB6849.namprd11.prod.outlook.com (2603:10b6:806:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 21:25:54 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 21:25:54 +0000
Date: Mon, 23 Feb 2026 13:25:40 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <dan.j.williams@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Smita
 Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Delay inserting iomem resource until auto
 region commit
Message-ID: <aZzF1Hw6tZu9QXbS@aschofie-mobl2.lan>
References: <20260212062250.1219043-1-alison.schofield@intel.com>
 <698e2a0041223_8c32100a5@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <698e2a0041223_8c32100a5@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SN7PR11MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: d730ac6f-ef53-400b-1a36-08de73222065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nYxx5KMnhjRDfMlB1owKlvDIU/DZJGu+cDrXL36IRTuK56RRcIfVvCN3V6HC?=
 =?us-ascii?Q?Inj7wxxZkcPbk7iAFeRCI8aFOFeSkSXZLeOLCEzLL747PG4v74QGNv7O5pGT?=
 =?us-ascii?Q?5tZVWuijB9LSehB35fR+GzRKO40pyRuJatB45WXebFTRsK5SKdQ2EazlqJ+Y?=
 =?us-ascii?Q?f18qfRTTHr5mL1kWOBEsQR6ou6va5uBbDJoUvnnN7Dc3NyNWrMaQEwX7X1U9?=
 =?us-ascii?Q?GgPsP4iRQfo2AAwKyQ8jBVzBfBLwpsNz3x9GE0wX6hBM9xVG/k99s/upj5lS?=
 =?us-ascii?Q?4doaDOXcTpcvQiJ7p4ZHngr/Ijv8ut2yayXdV4TCmflMSgotuxIUbz1bqQc/?=
 =?us-ascii?Q?K+Ngxa6vzTQz94xotExeJsT9aJGGKGdBnmeMZP+001H3fpY1TPVYAlJGuXTb?=
 =?us-ascii?Q?PzFeeyxC7wvfmZWauQwkjrIbIElAYpa4fJo7PjxMG4ylntvtxXdQiMewnsm4?=
 =?us-ascii?Q?x7wIK6MtgWXv0Kv6OeWVcn58KtRxyzSBiUDbN4GgArrXAgyZPCb9IYhMnkc3?=
 =?us-ascii?Q?6iTwPAzZU58v1FTOPveSYMIJ2uVf+uR07khOwAqLOE/KebspJDx30HnguFRy?=
 =?us-ascii?Q?j3ujGJFtApeAuUCJxhEvFDhSoJVqwS+CjltE6tANSPjlNOgdRVPQrNYZJlau?=
 =?us-ascii?Q?7Yp2AS7dnLun0bB/wtCkKJ43ajpmmFyZBc5skYBrehlthp1jlD5lJoop+HBa?=
 =?us-ascii?Q?lgNPE6wI0Bc3AEMywWl5FNvgoBVPFZn1Ay074sEXAfcmBH6fHm7aOkz/jZjq?=
 =?us-ascii?Q?fjoKPRrUEuAz0pfhzbx4lDs0ppDXtHxcfuVCC4pG0nkkWHvVHkqPLm87vkSZ?=
 =?us-ascii?Q?w50DgiFYLVzOd5bGE8BxHxh5yXbUsKLCr2MDUIE4phIkjujXuY4V2ynvRzxc?=
 =?us-ascii?Q?PPMwuFfIC7vUHBcTFWZ2aV+E+FxXO9GbVt6pFd3y4iIky3kmeSoXx7L05q2k?=
 =?us-ascii?Q?sb3NKLdQE82msEKb4JNDw0+0AJ+5fEjJYzd725J1pIEi2UU+/b1PT21o7EKd?=
 =?us-ascii?Q?i2vpRdzPTFA8pN0lCT4kaZaAY3r88t1FLacl95vJcogrpApWMmQjX7F5EQ1g?=
 =?us-ascii?Q?IuF+hkHC5mL9eu04ymSxVlqUBCIoBymLnpXAGKV4WSo0zKVbyqDRqa2da3CL?=
 =?us-ascii?Q?83SEhpLQ82Fh4fkJKD2bSVzEJhJ+p5/yXlH/TjPp4ESD03OXobhB3Mk0SzM2?=
 =?us-ascii?Q?S2uAcKgeBBedRydRfW9w+IPj0sn4ZihiN54tOisjIOYZZBiS6t8KSbauHIcC?=
 =?us-ascii?Q?HRETibteeVGvXV/RF/wFcipzcqYKB1fym/tXssH1kfmDdV709/qgHPtRbc/A?=
 =?us-ascii?Q?OTeqUd5RGiHYydAXljNBNnhC1zg333eJHIpXEjFqoN/6N93723xSCAhOtITh?=
 =?us-ascii?Q?tXJaIgr5f17XbEoli5RRyEKmifFhWVdzQrUe2eOBWdHnSnGS/wLkn95EEgN3?=
 =?us-ascii?Q?8wC8CFuftdXSIpG5IHqjyclDs8xQfRV4/Adg4DDZGrdlbR7n4cR0xGeYOhF9?=
 =?us-ascii?Q?uiCS3EuOJWBpWqZ/EVo8sSEgNwvDqtZduaV6WB41hd+F5vTIzUpZF43aM9/G?=
 =?us-ascii?Q?4Nb4ajsVSKUqxQvGQi4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sogGoEdtsH1MSKiWerXRk1LuGumpUbFB8fOAyeK0EJPzUFt0ugQK9FVux1pV?=
 =?us-ascii?Q?YQXKl/0SXPAVrd5QT/NOrbRlK6JbTrRkxn1eBQCEhztI443mMWRhAjhyLoI4?=
 =?us-ascii?Q?zOb3joFycjRQU7QGJ9LmfbSPUi9Vfbn9p3YtXXJWRQlMlOaKuaUNt1O75FTP?=
 =?us-ascii?Q?aLeUVHybtphx45KxcTwm6TbY5ZQXG2JjtsVzmok45JxbUzTWQRvbCRDu4uP/?=
 =?us-ascii?Q?nUh9dmNeAKtXBxN8rVTobnLhu+rJyy0TCCKxQEQnFRT2hEbpj835fXG4CtYr?=
 =?us-ascii?Q?k5AYakN00d1dvjU9WpzLe5aKyv9CTPp4TYVcQnhF5F/3NMqibL1iWpNOpQN8?=
 =?us-ascii?Q?IQklBNHX68x0VBBxLc8VH0qnLj0kPVLzpQCT2VjEPXkwv8Mp2pedxVAL5hm+?=
 =?us-ascii?Q?9qF0Noou7awBM5smU0tyC6xozNmMvIuyPwKHemnmKN6xddPE0C4iGeATChGa?=
 =?us-ascii?Q?BQYv6RUBxpo4BoRC16zKykZ3DqWQ44GCfU5wLO83Uda5DglOBG0GpLzCabtG?=
 =?us-ascii?Q?hfYEU4VuV4QXIcn66j7ckcE/lK/XjHw6RXcRK7yc9xD2QNUjGKbYJW5K4dp7?=
 =?us-ascii?Q?yaFS7m4k3V/xu2q1pr/S+xXNxAFGe+5jF5fV86LgabRuIGUCGCu/ENpcqBw7?=
 =?us-ascii?Q?FQ6iEZ3gHyZYwZWWWoEXgodVx0d+Utd0WKQGK/BL2PnhBA2yb5AveSO9EeED?=
 =?us-ascii?Q?R8BjKFZzPkd/5Mt4tvG6j0Zo9zhh/jcM4pkMx41V+IoJSW2244OoU8snLdpB?=
 =?us-ascii?Q?1SQiWUGvOvTgeOv0fESS7d0hqCTM4p+zeCJ08xq5p6LX91sDGJsXXvAufH5J?=
 =?us-ascii?Q?ga0mCAnk9ezW6BqeeAynRFB3LeH0KQZVOEBsw2AN4PvJBO06x+SYz2kVv/7D?=
 =?us-ascii?Q?od3ACGNJbqDFRuJNm8Cs/fV/mSPhZL5YSu/8goZxhGOkAzYv0R6IOgQE5xor?=
 =?us-ascii?Q?gq2Pt7HXfZSnFLp9XGgZooNOyKgEsRvg7cIHVRCPt60EkpR1NjEEZAscXXek?=
 =?us-ascii?Q?JeFl4dUMIzQzJibMXMRQVrCjF14+P3qAk2mONkm264mpRUUIq6tAba1tjpZK?=
 =?us-ascii?Q?q/eZIhzGt9anLXLQQ4tE8+0V7qhbEMh1VjMVkMmrLcGuHJnNle8Ya8EQ/Lga?=
 =?us-ascii?Q?aolablzgBC2UGhqKLYcJe5TlprOVkZXb+ernUr1NLIR/FOcyvCOlOpYkrfHD?=
 =?us-ascii?Q?aeei0qQJGHa03XfyaoCp0C0jf2xUmBz0KbE+NJbfvV27x57j0Vai8QDhSgiB?=
 =?us-ascii?Q?+CVtT2JjPPKE1w/Cb/hMrT7i3oi/uqgvfFxbdh9vERFT2EHnU3cBB85Co7Da?=
 =?us-ascii?Q?GIo/HA1g/UWUaV1ZB9Fv18DkqkcXwoFfLoM50mBmI6VDLJqZVeywEBXW+ddl?=
 =?us-ascii?Q?TujDo9YwREmtiOzcOKwogus0L/HgEMkTEkT8J+yU+v/oAKJb17AQNAWahUYa?=
 =?us-ascii?Q?6L5doah7EpU0G+qgDlr55jJPTDCattRnHhCbRKMU58a4o7yCqi8Jf4/V4TGo?=
 =?us-ascii?Q?YgqsbIcaIxwSb/XxE0fW7+xLNGKaHAJiC0ID6CoFzK6eQhNJkpDT++nbxWtu?=
 =?us-ascii?Q?M8A2iqY3Z1sFqm1GhEd38EgDhx96gTwRLrd5NauJGCioNooZS+JWStOJyI4z?=
 =?us-ascii?Q?w9gV6AOpjtxMNYnCD74h1pu5scPCE9aP6zp0pl8aGUfMzntO5Dj7V70Q5XnE?=
 =?us-ascii?Q?wjCRigG72SA0i3bifhA1DypP96IwNoVsT2MIFIrRMmQB/xIMtgzH9WcpJKrE?=
 =?us-ascii?Q?aNJyXn0tAr8OO7FF5xe6amTghByKR1w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d730ac6f-ef53-400b-1a36-08de73222065
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 21:25:54.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW2d7s5EAvk5tCdCQ0HKrHKaQNpdnETj96hi/eW9ibtYthqBqxRHa5yZfu7G4OL8IZzrS8cs5/Um6DnlLihevO+eCFhRkVNv0dfcVJfTaL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6849
X-OriginatorOrg: intel.com

On Thu, Feb 12, 2026 at 11:29:04AM -0800, Dan Williams wrote:
> Alison Schofield wrote:
> > During auto region assembly the region driver inserts the region
> > resource into the iomem tree when the first endpoint arrives and
> > region assembly begins. If the region later fails to assemble, the
> > resource can remain stranded in the iomem tree, making it appear like
> > a DAX region is a child of the CXL region, when that is not true.
> > 
> > For example:
> > 68e80000000-8d37fffffff : CXL Window 9
> >   68e80000000-70e7fffffff : Soft Reserved
> >     68e80000000-70e7fffffff : region9
> >       68e80000000-70e7fffffff : dax19.0
> >         68e80000000-70e7fffffff : System RAM (kmem)
> 
> ...but it *is* telling the truth. The truth is that multiple objects
> have laid a claim to that address range. The region9 object has reserved
> part of the CXL window for its use. If the "Soft Reserved" and "dax19.0"
> reservations are removed then the address space should still be reserved
> for the region. The collision only occurs when drivers for those
> competing objects try to mark the range IORESOURCE_BUSY. Competing
> claims to the same address range are why IORESOURCE_BUSY exists, benign
> overlaps are ok.
> 
> Note that CXL Window 9 is also reserving more address space than is
> actually in use. Like region9 70e80000000-8d37fffffff is reserved
> address space with no active decode.
> 
> > In the above case, region9 failed to assemble, yet proc/iomem shows
> > the DAX region as being parented under a CXL region. In reality, the
> > CXL region is in a disabled state and the DAX region is managed by the
> > HMEM driver.
> 
> iomem resource parenting shows registration ordering, not actual
> parenting. Most of the time the registration order and the parenting
> lines up, but I would be surprised if any use case depends on this.
> 
> > Examining /proc/iomem is one way users inspect the memory topology,
> > and with this patch that view remains accurate.
> 
> The ambiguity of iomem resource parenting can be resolved by looking the
> device-path for dax19.0 ("daxctl list -RDu"). It is also resolved by
> noticing that the CXL region and the DAX region are using separate
> memregion_id values (9 vs 19).
> 
> The extra effort for incremental precision is not needed, the contents
> of /proc/iomem are accurate.
> 

Incremental Precision?  Isn't it just wrong? The region driver does not
have a claim on that address range. It inserted the resource before it
became a decoder owner. If it wanted to place a provisional hold and then
drop it on failure to commit, that would at least be internally
consistent.

In retrospect, inserting the resource prior to commit was a bug in the
region lifecycle. I can re-present this as that, so folks do not get
side-tracked debating how users interpret memory topology.

-- Alison


> > Delay insertion of the iomem resource until the auto region reaches
> > the commit state. Introduce the res_want_insert field to track whether
> > the region's resource should be inserted into the iomem tree.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> > 
> > Putting this out for comments and I expect to rebase on 7.0-rc1 if 
> > this is wanted.
> > 
> > Today it is built upon Smita's v6 Soft Reserved set [1] because it
> > is with that set where the failover to DAX starts happening and the
> > confusing /proc/iomem can appear. Without that set, the resource of 
> > the failed region appears in /proc/iomem, but it's less confusing
> > since it doesn't show any children.
> > 
> > There is an option for Smita's set to teardown the CXL regions when
> > it takes over the resource for HMEM DAX, however latest revision, v6,
> > has taken a gentler approach and leaves the regions intact.
> > 
> > 
> > [1] https://lore.kernel.org/linux-cxl/20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com/
> > 
> > 
> >  drivers/cxl/core/region.c | 32 ++++++++++++++++++++------------
> >  drivers/cxl/cxl.h         |  4 ++++
> >  2 files changed, 24 insertions(+), 12 deletions(-)
> > 
> [..]
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index c796c3db36e0..2b977ab33af6 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -480,6 +480,9 @@ enum cxl_config_state {
> >   * @interleave_ways: number of endpoints in the region
> >   * @interleave_granularity: capacity each endpoint contributes to a stripe
> >   * @res: allocated iomem capacity for this region
> > + * @res_want_insert: true if the resource should be inserted into the iomem
> > + *		tree. Set to false after the first attempt to insert or if
> > + *		res originates from the iomem tree via alloc_free_mem_region()
> 
> This is too much "control flow in a data structure" for my taste, but is
> moot given the comments above that this extra effort is not necessary.
