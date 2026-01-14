Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B430ACFF;
	Wed, 14 Jan 2026 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412378; cv=fail; b=A5GTvm9VU1EM5/ZsOckOrle5J0tZKFXJRFTk/VAnhEW5RcVmhivdMyjRztG+wyQPLKPP+URH4OUYmBUNPjrkGZrSMkCmWEgR/Nv0g8dQUJmHMpgoX6ov0hLGPvHsoyD7EDCKUDH8c89dt+hgTjjJnEBrybnwTSr/ope1VTl+EwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412378; c=relaxed/simple;
	bh=twj6WOJm5juJ/LSzK5TLVpkUwTRn4qQTxp/L24tj/eg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aF4T19i0FP3c67fGzJqIHh7qO38biGJOZHBFJgSn1EVQsHd2XnP2/AU/7EVVT4tqKgQZ8kyGd3utcbJJw/VgWJmyR+5ZwEqH1PY/rkr0cB6aukmgf5SxFXi66eF0fyDdh/cSG73mslGox0ZqMEoDEVYBw9xO9v3UOOHeqyUFxEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgrZZQ5W; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgrZZQ5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768412376; x=1799948376;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=twj6WOJm5juJ/LSzK5TLVpkUwTRn4qQTxp/L24tj/eg=;
  b=bgrZZQ5WkNZGMVF33si+5TJwaY9Hxo4xN4AUiP6fSGxnTLV+AgKPbXae
   CKkka8vGRHIezlWuU/FWZJvLW8wIByolMdnI4pUtW781l1w7d4gg8FjpG
   QKqzBJM6EmfeghrD9TQxL0hAi0bfCcIkRsK+ZWUw8OAhFJNJoeEWuQM2f
   gPZsxfwbNoNJNertoFjeDCJ7B4gfx8ixW78XBe68aG4QwPER1EpdV1J78
   PQXkUV+YoTsVZ3+nK+WckiC2tiAeA9bLcEp+aKQyhny+P+Tv61oqstq7w
   dlJggeXtC/goAT69ZRSZzpg8LpwIspUG6gaz/lvO44YKP645g+TwecSdX
   A==;
X-CSE-ConnectionGUID: T0Sfb6DMQKmWhgxYIIfi7w==
X-CSE-MsgGUID: u7ouxs+oRYm4pQdyN+TDBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68728905"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="68728905"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:39:34 -0800
X-CSE-ConnectionGUID: krSxvk1XRimErRJOs3XNcQ==
X-CSE-MsgGUID: VUsSmgL5TSmGaZUlXZHEeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="242287948"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:39:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:39:33 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 09:39:33 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.34) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 09:39:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wta3dl/+9CC0YrwQ1JINjFdfEMrVSF+bvR2Kljl2h6ZJYQtNE7Ric+B2QL3vGSGo9PyAUNq2Q0ma6Up30bfRVu2LGy09vr1Nvs+zIBJisuiXBpfBWal3jCxV+R9XNPkQ3t8hHkA05HgdBAgQZg1piVWktQB8tBUCGxnyhW4VQyyuC2VbTrViE/kq7PI8FUF8CVn/zez/LfM/KqdGqvrf77ZLQipwwIv8JODiEpo2P7cV59BcIu2O3kv2zzvZqNnJgLX2ze8dLO6rPZSuPIKTqd/Xc9YvvnmffTFC06nxT1qtRp7qUJ8Mh4dgQAUw5hVv3/y1MmgmYJQDZG9znVYAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/ZOsj71njPDdJ7q4tfX3bd5Yj+a//xxoQIJQXQxuzQ=;
 b=kR24g8z2RXGWyXaGoPEpCuOqFtYF1p290sljEf1BNYNmi4qK+OaLZsMIYt0MsrWZq+ykNav86Fit6YIEzDV8INc9vOxRdHFUipwModaZB0LJRvVCYJdDcdgok1O6wuWKeM6DbBvWincgZ/oMFHkXiwBinX2mxqvMhKmganFYW9LOwlK1tdYBoi0GaTPdcJ+Ds5xKpmE73SyJMA9cw2LoXDoQClJT06Mo58FecYfdPlryJ1e1XURJhB8CwyAwiqFYDzt2erxFTieNSkiXvOoWg+j0lhZpoLkhtnH6MKwF0d4OFT3Qa1L5q1RMY0nR7oC7tIEQVzi2N3ac0Z3OWM0DZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 17:39:29 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:39:29 +0000
Date: Wed, 14 Jan 2026 09:39:25 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] cxl, doc: Moving conventions in separate files
Message-ID: <aWfUzUUerjWelnPs@aschofie-mobl2.lan>
References: <20260112111707.794526-1-rrichter@amd.com>
 <20260112111707.794526-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112111707.794526-2-rrichter@amd.com>
X-ClientProxiedBy: BY3PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:217::31) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: cd47c341-5878-450c-3334-08de5393dea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mzZIJMMc+qK5rIZbku8FJpAW53Ol85CdhXBOL7y+rgEbumSOM4p3nEVE8oJ1?=
 =?us-ascii?Q?ZJiuh71gWuBIEnGpe/7fxL3ZvNNkcQiVi/VxxWzJGf52Ub9WP/jCKTm7LICD?=
 =?us-ascii?Q?ertBHvxOwOxdJa8r2Kr6ccDsdFM2utA7p1Ws1PzSK1U/MAfjx21L0OXs2XpY?=
 =?us-ascii?Q?eDF2oQOunJ+ov408ZyOrdTqoAw5ztWrLKSrikxuZRO9mtU0ebSHv+lLexFa+?=
 =?us-ascii?Q?idARWmyz4wnx7NhFOGHehfqqitq3oSK77VwsK3IrNOC4mrdY4i24hxlwj7DI?=
 =?us-ascii?Q?MZmgjASQcJYtJVOBs0MrplEdz77Qkzf7diObhMP2okwkoeyfo+Yp2sbuGK3b?=
 =?us-ascii?Q?saegXOEg8oECav8PSQ9CMhMkEsWqhOWzs1myUjV+4IFIPXguRw37rAieHozN?=
 =?us-ascii?Q?sX3TsCQBtdUqYfi+hbSSOSltDZg0MvmZDJb+ajPMEx/O4R9m9MFGm4MI99FC?=
 =?us-ascii?Q?HT2/6BYFl+MgKA7rn8wrbnIJOXQwvvNgIR6iAYU8Jf/pthWc77AvifaNk+W5?=
 =?us-ascii?Q?xTt9+d3eaxUBhPxqpAIVOXhPArTjc5s94/syUiVkPdsnk2XuVCqo1SuiT2dV?=
 =?us-ascii?Q?ALa/fZ0KiJUnLfeGyW6lo8CVe5YQgpNi1esh0mYw8BesYXHT7pzN1r89/D/V?=
 =?us-ascii?Q?M0GJLcyCvtDBer6oGVL9yJKJJV4j8nh8ouR7rZDK5MHrlVWHRyZUZYYKgf4p?=
 =?us-ascii?Q?2mYWD96ge3lXdJilfszeeJH3q9nYeOKq0X372dwuN2BxEHDlqDxYkrB/JWY4?=
 =?us-ascii?Q?DkeMLzcBNc7E3ZWoAuQnxpE41ZU6fDbxoyTIO4uSa+6R/UVnPXpcXC6W1ZS+?=
 =?us-ascii?Q?nnRjYtOq4eS9Jf3Mfe7kV7xU72vM9HN21qxRCiiqwO/s/V6ZCiRFOhHBzyKT?=
 =?us-ascii?Q?cQPBLIJuzMBFlSjC3frzc8QzhZBk2xyWk/4foA34DIjcT8lMs+L8VUAezuzd?=
 =?us-ascii?Q?x4wGJvM5GUhC0vjcoz/LI0VPlO3Vuv8MU4QrBPeApQ5qT+qGa/zhSjOfDuY9?=
 =?us-ascii?Q?dWcMqvbwHdFqEXpS42DSKpoWQIVgb2+laAYKR/CQy8yjZYUIChtciKI3U9TE?=
 =?us-ascii?Q?pFjRBen1azG2nN9OqIbjkaoAeuwlLo9FG7qcD4LWAEEtyC4H+/0SMCmcrV2X?=
 =?us-ascii?Q?smtDri9NxU7X3IyW2/6UYU5VTAWVsIZxx/JMi6O6Wq4q41c1s46V0QU7Mj7W?=
 =?us-ascii?Q?mORu8l6Yd1G+2Iwooqv32xNhu8OHfs1u5c3wzyii7BhjbCL4Zt91GloIG8EC?=
 =?us-ascii?Q?tRgkWioxNqrAfCrUKkJBba5tT8fiK2p+PIWLY+oddStdLJC+Ng7Fb58h0PMZ?=
 =?us-ascii?Q?wU7meFhb9P68vdA0cZg7Qy+ozx7waGxrJHUfxkHk8nWc9ykfnGXiw/eJwrQq?=
 =?us-ascii?Q?SJ0K4JNFXu4Tweo8aNci4xpyMqDXiLuALpLo/n9OPzA/b3ZT4oPWoJfiK4kh?=
 =?us-ascii?Q?hgcgppppi6TeQzdm8qIHPkU91dcgR7PXh63ngwbd8EyjZ+LE19LRdoOy+Awn?=
 =?us-ascii?Q?3/e5BaO6U4yP1DJkx4IQod7MlVdHmEcq1/YqWTI3PbOXw5BurSEPfMdoDZV8?=
 =?us-ascii?Q?WgGVGP+GQAcUvpS90OE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nuWr08L4UVdnF48NDo56kxOBhsVKC3FTGLIpP1r5Dpa++nJXBItUH5SkNRez?=
 =?us-ascii?Q?5HOElla495z2FvSSeZ5DAINlGgAbmMi61hKYrf83RMYtYFbOJHoRXG4if7Ti?=
 =?us-ascii?Q?wA6sYfXD3WTa/plabrMSpohki5MoqPUxSflvL+IdcdrVsYo+lG5iOPHI+UAW?=
 =?us-ascii?Q?+/fhUXYMntCpAgV+Kl98Qi6742bWWo+/TSo7JFMx0zHmcyspCTg/sEWJnYj4?=
 =?us-ascii?Q?YVmfnz1r2NkgFrwfYroB/IYWe25kl0tzqfRbhHmB1nbmf8aAlOVqNzoKB3Vr?=
 =?us-ascii?Q?tVlHBU2nDWVd0U7T81HIC6/E626gsawUfCVn/RwzRBFG8HuOV5g7UYfuW71b?=
 =?us-ascii?Q?XnsaSVrHk3h37v4DPF89LK6ps2jZrrTqF/bBL7Nf+RWQ7iJEhw/pV9YIdeK3?=
 =?us-ascii?Q?o0fqEBdlMpyeJedjkOqB7PbtKVHR+dFlTtrvGzfJUKxN+Fn3u440ZoTiEeGN?=
 =?us-ascii?Q?DpSWEKtNaCexZm0al12NW8Rw5BjvcQkVD0R9wK0HauffdDPJXNXvtob2CX/p?=
 =?us-ascii?Q?NvzlWUGQ/zZZjl8nLvhkxZ5pGoMWIhAFi9CNj83a4NKkgnAU2tlMnSwGXPL4?=
 =?us-ascii?Q?dRdDdV6O/Q5hk0GMmgAsHsPCjpq5+8+fE/7zKFhi9LlimLfKiQO6GG61YrOL?=
 =?us-ascii?Q?IoIPBwzc4pb9fOaJrOwQfWcKhrIoUdO4hedd7nK6HG2+Fkydk4GXyaC1dJBE?=
 =?us-ascii?Q?lXdPIUew71PcsOmcMon/Siad36FcLJX079J6EfGJrHXXWPWXp5GA4EU0sncy?=
 =?us-ascii?Q?zWMiEYMjWOwUCvRnetFiwtwR+re/ucOwK0Vxmi9s7ESTzi96guOX3BkRnvFt?=
 =?us-ascii?Q?Y6ZRxQ8KU9tOk+JOxjgtdfRlm9u2JvdkQr2+f7cWKt3bkIvi93Du5swyZmsb?=
 =?us-ascii?Q?xf67xm8nfV8LazGpKD5rYe6MRSn0HM9vXZApQCZxwR2x9N0Svos+T4N/obk+?=
 =?us-ascii?Q?um9RKGXQKriI1VflVnJTtNGTIDv+z28fMMXLMqzmtHTmjZfhwOLoYKGifL+M?=
 =?us-ascii?Q?Rm8P6tzIAw5TDBu4pKvWoXdXwJk+iykiX1V8LAkf8MaYH034HXf0+4lBBLu+?=
 =?us-ascii?Q?st4lQd0s/bGKlE5GFLHGRUtfZfJLl4DcNiiM80fIw3Unu14w4jrt79AGkE2o?=
 =?us-ascii?Q?USkuIhKqmDOtTzJWItj7SMbyQs/D1YfLaMePGFrJ4nfYPy1U2OCY/eJkwnyt?=
 =?us-ascii?Q?HfCPzAcdcl6H8I1fT3dGp4QhL5yG4MUwnd1qvihFkfgYCPubpochhdbWhl4D?=
 =?us-ascii?Q?qv1C8dvWIA7SuywGyhe+86e4gXS1+qatn6CkaIEk/9XUn+0FMfqoXoXReUoz?=
 =?us-ascii?Q?LjzKqb8I04q+w1b9FODiipbCXj0x0ydk7ibmrkLJO0uF3+GG7DdNNRZxb0nV?=
 =?us-ascii?Q?6TaCVVhQ5q5mbu3JjFYVk7/47LTVabkLpLH03MJfLD+dznemFswSdliVzLf9?=
 =?us-ascii?Q?KEuAN60Q9XiQi2ZmqVng08YWwqgNek5H20vG8uLKuRp9ZOjpTcQ/v2+oDVTN?=
 =?us-ascii?Q?9NZxT3aolrbDKbWQ7nHGkHP4S8I5d+yw1eqKtRgy2rpbB7Ngd7jVD2n6tCEx?=
 =?us-ascii?Q?ztlkwOnwlJmdTbM9cDzv+rcn0+dojAFeakyDLTLvKPsQiDPuOcZdJ9baDnyx?=
 =?us-ascii?Q?ccZFiPGB+2ePW+CtVBVe2JTaj9/nh/cOAj8eG+Im4Q7vrmuMMwCPsmoT5tko?=
 =?us-ascii?Q?6x0tjZY6LNwfFdjsG1MmVW89jdyVbYIEKWPxDFFAt9JH167li5BOlvAih6Cz?=
 =?us-ascii?Q?6Sgle0g24PK2K3NAjV3u250UfOZmJEE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd47c341-5878-450c-3334-08de5393dea0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:39:29.4562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lj8KE8juJA3ZETdEpWe1dc+UsUb/3YOleFeHcWrLb+ytq9tD64n8DUp/i8FAo2/QmPostQyi0BLX6Mh0ijL9iG9F0/p2U0fli1KHu4ZeWHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com

On Mon, Jan 12, 2026 at 12:16:44PM +0100, Robert Richter wrote:
> Moving conventions in separate files.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

