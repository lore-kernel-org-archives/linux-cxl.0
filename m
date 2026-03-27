Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831E35A3BD;
	Fri, 27 Mar 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630416; cv=fail; b=fSVIvuaJgfRsIF09oG+yfGUQXledipEjzxarp63xb2lUF4x+lVH6QSAE+9DFIL8jubhTY/4IwEQ+ASnsEhMNHo/VImJu5bC+xp8y2wOgimurXSPmKFPlUMVIKz8wWfUAPETECH9Cfe8bXbt3fxay4P/rPQ/QPcmncmF3U/IOCzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630416; c=relaxed/simple;
	bh=EaH9Xp2qRiZ+m91Js7uW9dRvM2n4KUBk9juaAZuxhWY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WesVN6QP5pGfJLHymHFl4GkUV0d+vsx4NCwhcIOZrPg0zYJGZyWnAJa1XX6xQuff/exvqTD+e9S9CiwtUhIv7WQdDh53n7plUMlNASCwZ7IPLbRsX4L2Ki8e4uDsI6EL4ALPwibs3KZo5oTeBIM3QcIYEKeIJJG2N8Jfc15TO4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPRRCPaq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPRRCPaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774630416; x=1806166416;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EaH9Xp2qRiZ+m91Js7uW9dRvM2n4KUBk9juaAZuxhWY=;
  b=FPRRCPaqZv9qF+pZi391mOqRnkOIZKZdZ5wetwgAPaJx8SV53tMGW2sP
   xc2buSIJHTLx0OXhR9ekhuPBha9KgXklewSMLvLETYA+BHQr8ovCccPeV
   gPnBd0UFwXag5OKAa5XHDMF+xFYqETO1krhLrUBkytdH79LtcQpNeaB1t
   IsQAhfqeTi8Cf/15lwyd6AYRp+xrz8fWQP1pvHHrdeq9Plkfq+GOQVWAE
   QDK4hLfwszCp2GtEAW6jWE3csBWqNlc+AUVGEBGNsNAVhs0FLR6WiizEi
   7aYBKBkCr8UM1vMicphgJuExecZRqXuLwyBBs3UkmDuvnGNukLQjDSmTg
   Q==;
X-CSE-ConnectionGUID: lDe8XajsTtOnvg+01jrb6g==
X-CSE-MsgGUID: LS69kspTQlqg+t8UrHxqWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="98324133"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="98324133"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:53:36 -0700
X-CSE-ConnectionGUID: vERptGeYTPCj24u4QXEpzg==
X-CSE-MsgGUID: ewmx/ycBQq6+h8llWfnz2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="263316588"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 09:53:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 09:53:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 09:53:34 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.15) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 09:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dqh++1Q0VeBnPOzapVvAPJapzc5EzVl/8EFl2FrJ261zclVAb0fupQ4lsymVm22+LzcA2XPNavZD3Cl9ctBt4qpIbeyhdYdVAPThSZglXtQ9t54eM+mAuRlncOOSfDEBxtpygpRYslmFmYpn2GdWiRJUb5zKLzllrd06Fh387wiLUI3lqEFnxMWUjiEMkvmra67kKNEOWF5JgadWqpRTEZr568jMRTjQ+2o2fK2uj9EHC1TbmbiqZcFV4NR9sLs/puygiD7M1MWXUEPoLwdP9KPBjUu3VgYmGaAsEg/woYtLuDcQFxEfs/zR+A1GGV/M23M48BzcN+N3lCYnvX+omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO7eKt5dih9hEF/2PTook7y9Hk2XEupXVslDnNk0IWo=;
 b=UZhLzwZLSZFIipzl2We/bcPPfywuN3e3xxXz7HfUXMZzprmtQTuJaBrKvaZdcaejk7fkBV6wVigWgIwQYjt6x3fHkvGWizRG6mL/VcetVE+TrGpA+M8K6BdUEiSeZhymRBZT4sfMiREE7wb5+apQnNLLPjHlvd0Ee9vHQiK87Ry/H8eMW30sFXXae5qg7hxsVhwGJnf/xOqqhD4pSlHkuI0UmV7NEvvk9JLFc8LqKUuVcUCd5dxZ8ZmuBhgsceouXXOYMMkbSmA1IcXjbk0yBcnyO30CZKFd/czBhaML2TQeWqavcYgJNjxF3YB6d1D+xM2yJucP/t4yO2NEznEpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SA2PR11MB4825.namprd11.prod.outlook.com
 (2603:10b6:806:111::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 16:53:32 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0%8]) with mapi id 15.20.9723.018; Fri, 27 Mar 2026
 16:53:31 +0000
Date: Fri, 27 Mar 2026 11:57:22 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 2/3] cxl/core/region: move dax region device logic
 into region_dax.c
Message-ID: <69c6b6f2d9089_1771f410066@iweiny-mobl.notmuch>
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-3-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327020203.876122-3-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:303:b4::22) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SA2PR11MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab2ab66-cbfa-4fe7-c32a-08de8c21608a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vGx8Q/CsrLB5a6oS6IprirgTsR137lAihzYOGNGVe97HKVYP6qdD9Rspxw1OoB/5yYlGgHS9yw7bYVxoDFMpqYlSulQeRsBrgn5hty0qg+ggUT2oV15qJGmdWNC2wp8RFqzHzHtu6uuidabs2Hh2+sVtxJX+nIwdJ5bHOwoyuIPqmm2nMMDQ8M/yo9cTUgegXyrimdkLwVxg2E0W8OHHjWRqVpsaNqhdfbafh7xcB94tP2yxpLCaJDN8zK96mLp6o9vIJ65LgIRCSsWORcJQgLHm6LQCclnNUFAcsORkRccgD8N8jV6a/aQ7MCBkaZwPVVV/zYB90+Mc7CmXbl/fiI6d1/2PwRCouBC+YaRhFZWpzFP53ynsqjY2TB0Sf3EDQM9efM0qGTjLkJPnNIqGRkwGRXpd+TIs2M0QM7YwkLsbcw9Y0Uo8C5usy8G8imJVBSTLX30HB2kkq2UaqQVjDYtouS2/zNimIlQ4QtpEu/MvJ+vjxmhb06ZP6jko9zy655y7KR0hZA9U8l1gC/y42ZEMUJUNt+MezjcSZAcg6xiaHM9ZCV0o56CZeqQlRebdh4C7XHDH8BIp90WP3DIdpQTQgXn/X5Ja0Xzi1KChH+K4XquLh3seDQYRFPmneSxH7/fjiJlpHGE+pAjVlcweZRAh15WMPBbLIE/OriEpcykRcGmtUB9Vu4PxHu4OFfZy6c3Ddl+qZLJCBnFprie+w7p1cEDDtOwiou8tg9/CsVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HdXkHoXb6Y3taSAvK0IjeB6Upjkd8wFY4aKUqKREvQrv7JwgaWaDZfVcfIRW?=
 =?us-ascii?Q?syoSMB7obWGhIC2FURCBknZoMQbY2GQatDBqQsBQQn6W/ksuCKYg4JyppGsQ?=
 =?us-ascii?Q?M/bhVgkNs7bMN6S0yp4Cdq+fnlBQWbe9fW7gSZP2yKOa7eoqO6Ezvym4pRzm?=
 =?us-ascii?Q?n6eYzYKCzQq1TLnmYdhY8BQO8uiW4gXlNP+ZYQ7kw6VNjVSLtoGho8HccSbp?=
 =?us-ascii?Q?9e0JG3foUx+rBUGO3v+F1LVLxk1TnNLq/y9RgAm/TZNn89SQxtYbT73tIhb2?=
 =?us-ascii?Q?bh8PWP4Lom/Pgvss9N+PEJwzZBg+YQHWervCuTi3sy+CEuhtY72eAuU1B4aL?=
 =?us-ascii?Q?sBbCopM8zApNYmIBfZ4i+OhpjlWabrc1ADPC1jjhp5aDWDdGnlOFKr4F5ck9?=
 =?us-ascii?Q?5xrdzZ+mFvCfeMaNuJZnI34vnzDBKmz228oBItX9YcIGLSAUbRhEok3DOSfC?=
 =?us-ascii?Q?gGRBnCphIlD/kyeqrjPtLYivnoG0auH+vPlKjGCthn+Ft0oGk3LFjDk0VLwX?=
 =?us-ascii?Q?wvWiLD4O1nTUjyn5Or7GXfoMo4l1lBRs4/Vr6mduz8tcniR0JEssGmadu9Ja?=
 =?us-ascii?Q?OTUAdHsbF9+V8LP4ynZsWxJVFyUVn0GNYqeRk68ou5vq7SgS6/E7AqW4HjhT?=
 =?us-ascii?Q?NWfk+vv4R+Z5NTeq/YL2qtluTjIQEr07J0ezNTsIJnUyN570ey0c6/Am7wTs?=
 =?us-ascii?Q?jdUEwNU21zsagC5VXWypcjkkQpChlphcISq6ITsQ8Kxlq4iIGfYC/mpmcPeb?=
 =?us-ascii?Q?SNXX9CNHX3GBk2v5OaZBvZrYgnv8sd2FkXqHbjIM3ldyR+JDnCezjAfZiry9?=
 =?us-ascii?Q?sKWgEG66/txNrJlXZoT60gvWHao+6P096Jiw4WZ4Yqd8RX7yVYjbkWL7FQtx?=
 =?us-ascii?Q?+0NCupKpdmRd992MbocleEit5ydmNf5UqvBg340jLDHD68TPb2Md1+ZlxuQg?=
 =?us-ascii?Q?JuJB1NpfbLP+Zjqtaz6CiaAB5reujQmvnM7dIbXeN95GV8AZGGaHmtD/4GYj?=
 =?us-ascii?Q?QXfhJFKysLDzyWgp/1v2yWZocQ5AYiLU/z/fa7ee12JhN/97eFPqioSnb6PO?=
 =?us-ascii?Q?V3L/KBdB3GrShNK8zM56yfmXEzh96qSVeLEBzK4jL9xK5Er8XKT/iUIftpVb?=
 =?us-ascii?Q?HSLjA9hCXawZBq/HkgRzyYACRAe5pT3mb2L6QzLpRo8VKftnKqXgAtJdONj0?=
 =?us-ascii?Q?lT7qlwteS5ELBE4nUXveq/VNssRX7eVz2+aKHAzG3xGt2NGYy4mlJriMFhMt?=
 =?us-ascii?Q?VKMfwcWJ0VVUq1+srtjVunDZOq3Lv/KLHwkLfJUa/4Ec6OlcegYRb0BiaKmz?=
 =?us-ascii?Q?Xke0waW2iSz8K7ux+r6Arv/JeUVGJMcMV8i0JiLHEbYCovaB8et9NBOc6RTK?=
 =?us-ascii?Q?/2PIyY10QgBkDm2O9irNVTN5Akfw6q1zdrnTxpZhpGCa2iyi3Vgam32rfZFN?=
 =?us-ascii?Q?iYy5T9UT+O/RU/w1ztanrOhJ3JMbka449cW34Cqi8qUB/Qf9/ZymmfRR3DQ4?=
 =?us-ascii?Q?CtCrNreHQ2p3WjoPaCfeOdv/Zb6cySvGRYRayFs3t2aS6SPhU28iO0XBFgtI?=
 =?us-ascii?Q?1Cl4GYdZNZ868UNgbz+Lyu2Dw/IYdgic8gR8Mjin+WZxWn8sQec3T2+G8luH?=
 =?us-ascii?Q?8hPjj5yfCmnJYKPB7Yg4B9mtM8nHYuuyZ6tFiKn7V4wiQAShtBzpvw4IeCfN?=
 =?us-ascii?Q?ll+2dVCf412QISveWhm5SoC+iPRoXHaYCrP8kj5oOrdQBA7zdkkaJOv9PpHE?=
 =?us-ascii?Q?QBODlUDESA=3D=3D?=
X-Exchange-RoutingPolicyChecked: b5hELb6wa7K4C5IzwShbGIfXeHJjg7L1aZXuPJjUisbFzPI34A3/eMqOqmFrwoW3y+a+8fogl3soOSVMqN2u3BfL8YpQIKu7Y6tfbr01nQOJczifZ+PBfIUT+jwz0MzG09ikWy9WfO6BfJKambdcahSlt1M7FQQSNg9CNUy9Cu84auRnUWyUe+etikeFliweHorHmAP0H90N8tIydQLlr8c/jLBmLa5IcsEXZzzBvHmIDYHv77abOppWXWgNl9vls8lFaLLqJHpItZ6JZ6E6XNG89YAAlscGLOBgF54ppcImVegin5cyqh8C7R6TX9pHMmpVdsq2fJp5oVf0K42Tuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab2ab66-cbfa-4fe7-c32a-08de8c21608a
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 16:53:31.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pA8S4fiM7jXiq+AePsEZzUw8NhKSDRXiRPASKpytXM+HqqYYqAle8LkZeE68UF91BPJPn2ho3ztFmbCIMVgBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4825
X-OriginatorOrg: intel.com

Gregory Price wrote:
> core/region.c is overloaded with per-region control logic (pmem, dax,
> sysram, etc). Move the CXL DAX region device infrastructure from
> region.c into a new region_dax.c file.
> 
> This will also allow us to add additional dax-driver integration paths
> that don't further dirty the core region.c logic.
> 
> No functional changes.
> 

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Gregory Price <gourry@gourry.net>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

[snip]
