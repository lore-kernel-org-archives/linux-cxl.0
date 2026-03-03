Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0223909B9
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772496327; cv=fail; b=T0UY34tyjUxE26kB8lzgJSYX0hLs4H5WpWfwhqE2HkkLegRh6qzWUjoQBeRRfrfpf4V0RjHt4sJz0GlLvaOAjhmQeXrjcqSOCTCHtUJYsSJBd9zpwOD4jmBEpQyrv+nNxZbqWCyC+7z7xubbg0PO86JnztOa2g7sc7ATj/e04GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772496327; c=relaxed/simple;
	bh=7ieUwbcUhC7+6KodcXYCtQqFgPHJhGKJGKSsQx4ArEc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hS9bFVgYLq7U2hQEhI1WBs8ZV2xdmUIgfK0r+svlwbRJUqodZ9cA0HQrIOZZk+VT0b+ezEvduFeD9KEXBMrpUZSU0PJi7xxKbBgRzSvYKaBUllEAzV5Vz6cNsZm+u0wqIlXZ59HidkjUINJ86rUFtgnv/yioagMFCGFYs8ye39Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4TmJN+h; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4TmJN+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772496326; x=1804032326;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7ieUwbcUhC7+6KodcXYCtQqFgPHJhGKJGKSsQx4ArEc=;
  b=V4TmJN+hSDGHKEKHYO1kyHzL/RmhW25CJxSGzCVBMlfUXf82NiNLznav
   WX+CU+++H0gzo2say9T2csWP02eYThFmCUjJ1B3OkRwDf3lVrZU1V+8Nu
   tp824G/LvIRwG7AhDrWAh/sz8z6njqdWoiWrERUu3xzpjTp1f0CzW0Luf
   XEvFCDQX1dA5E4okDrfhUOUG/SFIVJjkLcS1u1YFfC1JyZywT9NBXMN7t
   BTvIF+6iqtzLnDHj19LVaUys5KA8Izgd9rqIhJTdrU8NZnt2fr9nvY4cn
   Y5S+80qZUdUX94VDkNO6LyDLWHQchfVmIr36vDzJfGO2Ql1ncoqPOG8wS
   g==;
X-CSE-ConnectionGUID: TzlPVh3YQ3SKX7lZzNjiCw==
X-CSE-MsgGUID: /iiWp4vQQMSE9wt74yXosQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="98991910"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="98991910"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:05:19 -0800
X-CSE-ConnectionGUID: 8ZEMTOj9RXyyiBGx4mZe5g==
X-CSE-MsgGUID: dMYqGGZ3Qau5vo7QBLqTog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="215391850"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 16:05:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 16:05:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 16:05:18 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 16:05:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkBCg5FjQu1UGevVOdzSCV7fdxn7C7TIgoywijii2CKKLFCCwPW42Q/8/UTYdwA+6jfYq3EwlzjaCHHyiNnC9ag2VilOeWUA1gqd3zi4eUlTFonUq/q8V/i2ZuX8JxDhiveePhlM4i9+SolHzHFRFnpTGLRPBIHgLwOI0aTtc3FNzF5V+ZEQI62F7LH6wr7aI4UiyhzHh4ebShJt9M12r0o4BosMxtwN775Q4Snu3BWZpZRSy8cZ79dyOumjrOgyG4f1Qz97d//BasvvDQPhQas0QCsTxBEwI3+ihbemojBkY1u1AGg8NpBY5A5nyAdVXlihKMJNVld9Q7tlogOeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhzO+I7Dj0jXRU3yE6NvBxWqXfDFRmPomIxUea/LPKs=;
 b=Yiu+wImRV7Q1Zp7EcSdcI0gG/1ogbsaSAyITuNhv64XScPMxf/YW7fjF4D/joZ/9Out0BnG6g6gcnGIs1wDrI9vvPJuKE/jlmuTdzBySk3c4jBWHdQVo2pgL8BfmWaNj3ADaPnkga3EiGER9YPx9nheW8bWhbYD7nAoLOlEg5M0vj0vMQuzcTBdnyyjGkyTgXS9jp3jRvsGCf9u39F+DBFrgwRbpVyMMuyCWate8RgSrHLwhOpxZ/l2fbLShkHPgQLOPrxu6sQC3LW/9h7H0suMEcuwxL0vitKDq+6vduw9L6GqcurQcoNCXtOwxO25IeR1dRSqlf2siyVeDLrRdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 00:05:10 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 00:05:10 +0000
Date: Mon, 2 Mar 2026 16:05:06 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
Message-ID: <aaYlsljwigiehmg4@aschofie-mobl2.lan>
References: <20260226184439.1732841-1-alison.schofield@intel.com>
 <c3a07fee-1a91-4f7c-a279-fb15be36a531@zohomail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3a07fee-1a91-4f7c-a279-fb15be36a531@zohomail.com>
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|MN2PR11MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cecc7b3-8d0e-416c-4382-08de78b8892e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: OSVtRsEhte+oMHmVjQZrij6gF4UTvVulRJVf0obJXKSlthiFFMYv6keIMAQb+c/K1robU9QVrfTAPwd0oT+8hwvQXVjRgrw0rN4G0JsNTPTiJ7qiljNHS29vGl5jPt/0iKoy6cMxpqfbCXP8wAi5taPG0BoRa1F0rgXk7WwIiQC0NpBct1QtDGhQV9oCdHDUzDZdvaV9Hm3bg2KqztAxtrVCE+x1H3vSYZ5hg2AVq+IHYjxO9UhEBVWKtP22IPOMsItobMy0vGaaEnyFX3tysdZNTicWsas6Mbdz6Hi7n4Qy+xQBvXk7iTjeB0isY1YD6zj4CKJCqKwUrG2nFaGohEs49Ca9FRmTfxxWMdvKiAt+rQRUZtCExStTH4n22QCkTP4Rc4ahuEAWbEL+5ApLNiCEKtDglNubRal13hLxqoo94zdSmrNiubLXKAXwwzLC0IoXuSb4tgSf+maHux+1nQNjv3JCju3kdrUhvLySkAcbJR4qtMPJC17gywuWsWKVkhLiBYB0lvgFN6gjpL4AlEur5L44K9nLnWQK5VOkVYnqSQFXVHjHcxDERlh4+yCRu6288mGAO+6dufseC6uqMpn+0jOKuWs4GgnhmFgwdPMuVaMsGv3k3Wm6+7Yc50E19Q3m7Y3JjVXqpe4Nj1CLIMN6nhzO7fMVcGgcIJwlCmj1Mr8I0WUn1fu+rZgOoHA13oX2TM41RV0cmN2oRrDTrg7rlnkVqu9vk0hnbnjBBBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7iOCswqF7gOOjF3Qb5WZVAnQB7prj7+A4I0ubEC2NcCldLEZX2UEKHHS/c?=
 =?iso-8859-1?Q?4s7v+EqCOcPdO7b/d18+dclFQx+PonDPsR84xBAEhsrJHjurXHLSRAzamW?=
 =?iso-8859-1?Q?39LkyxCZxQArj57dox8CzoytpwUJvyD5AqnS3HoUqeNtHvie39PviDIYwU?=
 =?iso-8859-1?Q?sH+/11clwLx0W6PRT/jWtq7n2RcdUX9+tT/v6A6vLiSSLt/dwmSnMVb9hU?=
 =?iso-8859-1?Q?tz2i6HF7AMiX/xA5TZwvj2yfg3n16ul/Jn2MUFwcJTPSBJUQLjDJ7MmVCo?=
 =?iso-8859-1?Q?/1e4IfBVmAovmik52TKyqOH6cldheB9lTdZk07Q3YOR24mlyBVvfIxwWni?=
 =?iso-8859-1?Q?hmbfvpVwp7dXOjhSI7EBA3KuwDDKh+muLfujiCja1qO1h4fTnAc7yPwD57?=
 =?iso-8859-1?Q?v36Yct+LPLNYmJBVjCJ6nbZC+046HD7c+Zy/6N5y9nIKA82UG3BRKGyT+A?=
 =?iso-8859-1?Q?PuLnSRL7Ag0Wq3eQTOAhLK0vzchAoTxTvvyqZX6E/F4aRVogkF3x7tctxn?=
 =?iso-8859-1?Q?E6ZgWa63VBzLuhc1IaIkJDAlwOwHz7yiyaLFO48ey0IuvlUoKWbh6se6jw?=
 =?iso-8859-1?Q?qozLdAYeLATbIRtsQfAipAup6QBGoq6dRcl62uFJ2t5jOmCJhAlCkTV95o?=
 =?iso-8859-1?Q?KdRwPdV0jm5C5ZJdmuz3WtNRVO2hnuNH4r+93DgQDgvu5rvibNeDt1D+TK?=
 =?iso-8859-1?Q?/sRYp3/y80X0Bk5uwIwP4moT5AA4mY19BT6FIop2/Q3oYaVRpO4ajKob+a?=
 =?iso-8859-1?Q?vXFQmV04dtG/8LXG/6WIftct6d11iXJxWWqV6mJK1bzPLR3YOkLPeIerE2?=
 =?iso-8859-1?Q?L8n8t+K98QeLfjOfCXjd3nSXtVYaznnKLTe+KmQTTIObj5xU037+P2+EMf?=
 =?iso-8859-1?Q?fiRUQB7jdjUyLDmd3HQQ7f6/lzgjAMrNqQJvTqsSBXv/gEBy2/Z1NPAJZZ?=
 =?iso-8859-1?Q?B8fALeyCjnxuiiaAHj1XBprmFyjpGPv+2wDIffcrwPs4dzxF9ChMFZzr4x?=
 =?iso-8859-1?Q?jpbZ9iIYihREQjNbLr97H/1Cn+T32nWtujPpcUtYep+2oZ6qtJ0JcS3g9N?=
 =?iso-8859-1?Q?nIxytRdU98qsLDg7Ah+1ZOCPn/MAZWZZ0t4d+9yXrEYTkt4z3L8MofVZM9?=
 =?iso-8859-1?Q?tNiopWKFGUbIOv4ZmQNOm6jtHxtRcZrRUsgVvmRAhPu5lwDJEcPHLePIaa?=
 =?iso-8859-1?Q?PqR4cq3hLVb/g4PGj8yftcsRN24njsfK0Vz2MLJeWf/YDX26V3M+ZriY7h?=
 =?iso-8859-1?Q?QyXZYnn1sNb8x89mA+/mUrQ6hmQ6MZXjbddRG/d/z/FMCW0WxZaESK6p/E?=
 =?iso-8859-1?Q?ZH1H0Rw3Bbycd6PXoYgzTk0pjImDb/mcDX7KbL2yD/TFcZWFHpYan23/AD?=
 =?iso-8859-1?Q?4J/aMNhLaHqGSiwP+y9gh/IBECzRR1n9AaW5hAzKuNk8vKtHDNRGo7DyRc?=
 =?iso-8859-1?Q?T/PphPxen8O5iMubqzHgi5LBnjvbXgJ+dJi4tBv7KzdCWHuGHdKa/8pAr/?=
 =?iso-8859-1?Q?IHW/bLUYk0kyA+9pfbs5pPP3KKFSdMDXTAcNBXXTRmnR0TPFUaJvpXa2fE?=
 =?iso-8859-1?Q?lVtXlvz3k/w8ailed/PHEeytxnrsQFZpTI6g5Gv/pseAOVryc3SS/5aQ36?=
 =?iso-8859-1?Q?g+vFwCAXlnFnoM9Et8Zq4JAuioN267HdGsXqeAhwv5Vu0ANUHx7QmuSNH+?=
 =?iso-8859-1?Q?oyPqLlnvqW97GpR9UK29rf1PsbpJzRqhoURtM2JZojBD55tXTwk31wkiQ5?=
 =?iso-8859-1?Q?raWfrCmfOu6goODNixZ5W2EpZShtrnkMRj71Rpw3rY2Qyt+w/xc8S5F4uL?=
 =?iso-8859-1?Q?cYknaFUVxvE5gpbxX3rjHxhu397374c=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cecc7b3-8d0e-416c-4382-08de78b8892e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 00:05:10.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+yWAE9e9fUE/CUlnQkj8Wn/++MoWT78bxnz/cYznyZE3SnopncBMJZaY6d7KS0tuMKwR5U9WC+Lwhj6DJN92n7rcJqUrRLRdlM7H8sddVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536
X-OriginatorOrg: intel.com

On Sat, Feb 28, 2026 at 03:04:14PM +0800, Li Ming wrote:
> On 2/27/2026 2:44 AM, Alison Schofield wrote:
> > cxl_detach_ep() is called during bottom-up removal when all CXL memory
> > devices beneath a switch port have been removed. For each port in the
> > hierarchy it locks both the port and its parent, removes the endpoint,
> > and if the port is now empty, marks it dead and unregisters the port
> > by calling delete_switch_port(). There are two places during this work
> > where the parent_port may be used after freeing:
> >
> > First, a concurrent detach may have already processed a port by the
> > time a second worker finds it via bus_find_device(). Without pinning
> > parent_port, it may already be freed when we discover port->dead and
> > attempt to unlock the parent_port. In a production kernel that's a
> > silent memory corruption, with lock debug, it looks like this:
> >
> > []DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
> > []WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
> > []Call Trace:
> > []mutex_unlock+0xd/0x20
> > []cxl_detach_ep+0x180/0x400 [cxl_core]
> > []devm_action_release+0x10/0x20
> > []devres_release_all+0xa8/0xe0
> > []device_unbind_cleanup+0xd/0xa0
> > []really_probe+0x1a6/0x3e0
> >
> > Second, delete_switch_port() releases three devm actions registered
> > against parent_port. The last of those is unregister_port() and it
> > calls device_unregister() on the child port, which can cascade. If
> > parent_port is now also empty the device core may unregister and free
> > it too. So by the time delete_switch_port() returns, parent_port may
> > be free, and the subsequent device_unlock(&parent_port->dev) operates
> > on freed memory. The kernel log looks same as above, with a different
> > offset in cxl_detach_ep().
> 
> Hi Alison,
> 
> After looking deeper into these cases, looks like the changes cannot cover the second case?
> 
> My understanding is that cxl_port_release() will be called on the child port before the device_unlock(&parent_port->dev). The put_device() for the parent_port is still possible to release parent_port before calling device_unlock(&parent_port->dev).

Thanks for digging in Ming! I see what you mean. It is possible for the
parent_port to be released before the device_unlock of parent port. In
v5 I've brought back a tiny piece of the v1 by taking an explicit ref
on parent port across the device lock/unlock in cxl_detach_ep(). That'll
make the second case safe independent of unregister ordering/cascading.

-- Alison


> 
> If my understanding is wrong, please correct me. Thanks.
> 
> 
> Ming
> 
> > Both of these issues stem from the absence of a lifetime guarantee
> > between a child port and its parent port.
> >
> > Establish a lifetime rule for ports: child ports hold a reference to
> > their parent device until release. Take the reference when the port
> > is allocated and drop it when released. This ensures the parent is
> > valid for the full lifetime of the child and eliminates the use after
> > free window in cxl_detach_ep().
> >
> > This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
> > devices present.
> >
> > Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Li Ming <ming.li@zohomail.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >
> > Changes in v4:
> > Move the put_device() into existing if-else logic (Ming)
> >
> > Changes in v3:
> > Scope fix as a lifetime guarantee btw child port & parent (Dan)
> >
> > Changes in v2:
> > Remove stray blank line (DaveJ)
> > Rebase on 7.0-rc1
> > Add Fixes Tag (DaveJ)
> >
> >
> >  drivers/cxl/core/port.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index b69c2529744c..a004da8fbe55 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -552,10 +552,13 @@ static void cxl_port_release(struct device *dev)
> >  	xa_destroy(&port->dports);
> >  	xa_destroy(&port->regions);
> >  	ida_free(&cxl_port_ida, port->id);
> > -	if (is_cxl_root(port))
> > +
> > +	if (is_cxl_root(port)) {
> >  		kfree(to_cxl_root(port));
> > -	else
> > +	} else {
> > +		put_device(dev->parent);
> >  		kfree(port);
> > +	}
> >  }
> >  
> >  static ssize_t decoders_committed_show(struct device *dev,
> > @@ -721,6 +724,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
> >  		struct cxl_port *iter;
> >  
> >  		dev->parent = &parent_port->dev;
> > +		get_device(dev->parent);
> >  		port->depth = parent_port->depth + 1;
> >  		port->parent_dport = parent_dport;
> >  
> >
> > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> 
> 
