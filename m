Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D2C27C76
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 23:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjAYXcy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 18:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjAYXcv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 18:32:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE0023674
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 15:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674689570; x=1706225570;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6m+JYqh2VTshBqE5AkpZam2Pv2w8tHUI+tvqZwGJfPQ=;
  b=Xji6mTsPcp5+0uSDmTJBjtqsiThNbNSDJG1LP1kYE1Gg0PdkBE01ubcB
   t1GPI4Wf+n8e2Wkz+JF5GaJ1aFzZrg6cPmgeY8PzvJXjCeFOG6sWz97ke
   Xggrrt6SJYMW4Y1ezh+9dy75Mk0r7fqd5Yh6b3dNiOVkTRRBxWog3Hw7E
   Rdgxs3uLMQCCEvJ+g/U0uPooBiykAZklO3fiIU8layg3jQKyaA/u/iXEd
   /J8T7mL9AvqVKbIAutdtwxll9RDoZZIXUmgVYHx73bahjYwTozQlFCTF7
   JZoE+HyteA8dBOU4Ozwuk4D4P9wtTAy/iZPUwPOpFJQR8u9ih0O8uTrEa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="353999224"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="353999224"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 15:32:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="693153542"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="693153542"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2023 15:32:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 15:32:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 15:32:43 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 15:32:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 15:32:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY96kkOFPN2KfVa6RH52KKHrSIdL/CoqE2tdkhnDHxuiTYWi5FAcktdXTIQiUOeoHHEFOtelFkwYLAVIZfgHm3rmiPqi7/njBlnjJFh2OA8dngxqRa6ml1BTXD4a0TdnAVa+jrgyDUeJcvYQeogZX/0ByIvfXGNiG/K6KOr2UHt/gCNRrcX7qBcXFQMpydY3bt3HC7X63UMT63ZZc9KrLZcns4h4d+27bqABOOD0CaWGxTEr4vzZ3ZGA3hioHzwA4WWWo9I+/oAbCzal11pkEXacdf/5mOl6/KdFBbOAB6z9m5Vh4+mx+lDVnGVL8Spnh0Hfb6CujVIaCszcjJlf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ijReAe5pegJH4ywUFgaxa7M+9BoorrOshR7PVBBMuc=;
 b=oRtWMBBqb5EB8jhFgRb5OQDMLiUrfcq2SObN4r8IKDn4ma6dCEzwsBS1Osbw2tRSK1oKO+dVntBXJywlxGgBLM+447G5ncOi2tXeOSAuXQUrjSC5kb6/hrXgMfecSk1s9ZXLhwiyFwf/7JjL3RZ5LviN+rKvifr3pzlWBJ+tY+R015kJWeX0Vbk54bTDjSxOrMikK34bll1o1T3Uo1Jm8xYkYx3aGGgFhNk+hcixWy9hGudBvHYutgTtkuiVnp00q+wIPYHV7zHDQZHEpo9i6ZaYInSsqtKlo+rMVtvB/v9+Thyh5xNvkb17GDYa8vijuZIbTFKVx1C6/KC08Sj7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 23:32:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 23:32:41 +0000
Date:   Wed, 25 Jan 2023 15:32:38 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/port: Link the 'parent_dport' in portX/ and
 endpointX/ sysfs
Message-ID: <63d1bc16877da_3a36e52948@dwillia2-xfh.jf.intel.com.notmuch>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
 <167124082375.1626103.6047000000121298560.stgit@dwillia2-xfh.jf.intel.com>
 <20230113113911.00007348@Huawei.com>
 <63d1b15d95155_3a36e52946@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63d1b15d95155_3a36e52946@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8918a0-1a19-40bb-823f-08daff2c7404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcS9r2SpXdOrl/jkE6Fm5byq4euuHhCuKXl0BQ/OWoCE5sqcEB+Onxq3t4YMyAJNtz+BcpXxvqYMCOjluvMYbxnS7g4Ez2gurr62XQef6KQsQFulFhiqWUuQ0U9Ad2eDKvz+Vf+oDQch2Nf2JvOSF81va/4EZT51j/Xvl2+RhLEB0Rnt2N5lS3OUljyCKNzyty42xXJtfjmy3sySVOHD6AP6hl4PNhu3s13T6jGJBtbZQ0Vlzi51vHF8ajOfFeo8wC96KE3z6MEmQhTPWCtNzykZQZYtw+WtbM3KWjva5F3HmN8WdEs67yn3YoV2BNcJBwWM0gVEY1n0dkB+JWJyUqKuKqscdB07ixCcjCij5U7emRG7UaXx6EiVJvnFsrJiwe2XAwUmbYiagYg10ri4thODqTyRdbo0bttoQEGy+yZtMExveJam51KQtTZX7SXlqCyAJs5URTwtPUCq9ZW0NSQnBymZUZbD/5ZM+kOg4ekDrZEA5bl2zx5Jf/pX9uK0MTkSPvDZX4uuFW+pagQnCVGSUkk/L/VVDkjMw/lwYTwyH9TW5W2V9vo0VCI00eq8/KblV4BUScORr4xnVVCzze3cs1RGldEcOdT6o0p4JZQy/iFRNS9q6byWjjnQWrhsgmjjkj0GQBpnZwCkkGZLsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199018)(38100700002)(86362001)(110136005)(82960400001)(2906002)(66476007)(6512007)(41300700001)(8936002)(8676002)(4326008)(66946007)(66556008)(5660300002)(186003)(9686003)(26005)(6506007)(316002)(6486002)(83380400001)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dQjR5ihBo33SDCDWmwB/6mHVl4/Q6Nyash3hIMA2MEpkycFJNgO35z9deDzQ?=
 =?us-ascii?Q?EU8PLwoKt1elaMvctRzu6pidDj6Blj+2g5W/gQA1u+i+R1ykt03OR8JPXqc0?=
 =?us-ascii?Q?NpT5ozPJpIcpeHFOov95Fptq/VHo16Zb97zftil17iZ1eDPa/sAJ5wGnHLAf?=
 =?us-ascii?Q?mWcWKo47K714QzDz1I1/ILTItA13333LJt1lyQtoY5hGr5Zk3sZHYTzimuQL?=
 =?us-ascii?Q?HnJLb8ws3sJ3Q/hA1aw9nucc4SWjxHVgzauwdAFjGzAF65KlPYZ6dymzK5i0?=
 =?us-ascii?Q?oV+4q+wrgNCt7sVsWdI9MZfQBfBJDCxlRYaXKi+nWX3kacvEigFquHfwUcpq?=
 =?us-ascii?Q?xEUoNq8snYmOtzdInrNELnO3Mp6eQAc4++/H1LBmUKL6gD7Eya6lZs1DSof4?=
 =?us-ascii?Q?/xKv3BGQVPMDp0lnrgSD5OYh3olGmQLnDctrKdIWkGP5QUUz+QTsinbZtUcj?=
 =?us-ascii?Q?EEi+kvSQ+zgXRNH2SifyoeiYTmLJ4JNjgiRHHUX+3mAMhZVdNI4PXhBg4SeY?=
 =?us-ascii?Q?zg5cX9YjBcG0dzwJyBU5kIR2yP3e4ZW0rv4GTGiyIFND/+clRZmmknGK06D0?=
 =?us-ascii?Q?jOVnHE8vpOOXzB8KRcu006MJoM68ZjDWve2YYM1VvCRHXJ/xrgSCwjMciYsx?=
 =?us-ascii?Q?NTUFNnJMR18JEyZijP+p6Oz9HjMPnhdOqOI84uLoRQ5PcgfzPNEsOjycTEf8?=
 =?us-ascii?Q?QYOmRWN+WVNptFVu4dAbVN090w9cJs4FJKObOG2t2q2ByZmFoT4drif4YpI5?=
 =?us-ascii?Q?eoWSQ0UmYZgK4dyeSFcAOblSlziCujTJVNDk+UhRie4DvbR44NDAuMuIUXm1?=
 =?us-ascii?Q?FjSQ9zRFS6M1Ky+nVoz9yHRas4lhyYOp2ghnmVT+mGqeez28tswij+qSkVUp?=
 =?us-ascii?Q?5gqnxtRXbwpyYIUJUYtQ1+AR7s6etfEcCzXHbl4oNyZFIvtw7fIvpA+bSyai?=
 =?us-ascii?Q?Z2Sp0yYbcmqwEqgWdyMp9458ZHqXwcl1sNg83DEFJuj0bdnrwvrnkcLlz/tF?=
 =?us-ascii?Q?XuCD5Md5WY2tiCLHVDAbay3aZany8YGA92NpDfZZ+M0gNE/M006Gj0YLNd7T?=
 =?us-ascii?Q?J4XHmfWvKSKBtHEYEuul3nYvP2eRkXT6U/QZNFZWwY0Re/UHhPu5TM20KTgb?=
 =?us-ascii?Q?Z5JI5lkzcMl3mgktfKIZzdktibFGl/0G+P/gU9ZP+FmrPoc8pIj9hMduheMc?=
 =?us-ascii?Q?IjtqT426NFJ2X1nVpS1bddbD//ykigFkv8np9VNc53jKT3uu8ufEAzZl+h7K?=
 =?us-ascii?Q?SI4Z+5VNZhWmD97tlVfqm5x1jaruceWU8hBDQ7AfGKQbzcWR1vqCnzN8OMbV?=
 =?us-ascii?Q?ZVSG1/WyEMgIJz4M81E/ftXLpUA+hAhf4DfoYKumRqXOm0KOOaXhg1XgFOMb?=
 =?us-ascii?Q?9QZneAu4CGuLgezvQIyrCz00dJj3mQNloeEWm+I8AhYYt7dXWYR/bdKBYZbq?=
 =?us-ascii?Q?HDIgAwmKUVmiCEAhqr8iNOGXnyJj5zNQqnFw/6LgMQUvb7c/JcneA/LqeA6W?=
 =?us-ascii?Q?Sdv0cBVRYwnbi2B8rishP83PhfhtwKE9sxyDpNlJYrDlJsMtQZgT4Wtfi1Jg?=
 =?us-ascii?Q?3bpgAu3I4JOXr83rsHtlXMl3ZXJgRe5w4HaEUMoSKLX7hJxgeAIa+LvXxNoy?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8918a0-1a19-40bb-823f-08daff2c7404
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 23:32:41.8318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fr1ZtvUiJKnedO9+0q2ZejDWqdYUhi/3PKnE97P2mY6/uov4DNBbeXEpwmoLyyR2GJZi2t9r48dXlTISwhpWHcXo4KGSjchKYhUZHIC2M4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Jonathan Cameron wrote:
> > On Fri, 16 Dec 2022 17:33:43 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > > Similar to the justification in:
> > > 
> > > 1b58b4cac6fc ("cxl/port: Record parent dport when adding ports")
> > > 
> > > ...userspace wants to know the routing information for ports for
> > > calculating the memdev order for region creation among other things.
> > > Cache the information the kernel discovers at enumeration time in a
> > > 'parent_dport' attribute to save userspace the time of trawling sysfs
> > > to recover the same information.
> > > 
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > I'm not totally sold on this being worth while as opposed to building reverse
> > look up in userspace, but meh - seems harmless and is consistent and tiny
> > amount of code so
> 
> Yeah, an interesting point because all of this could be done in
> userspace, but I think it is useful to avoid the possibility of
> mismatched expectations here, and cache something that will be
> referenced often.

Note that this patch had a bug in it, and the Documenation was stale, so
I am folding in the following on applying:

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 1b17c8cb48b5..329a7e46c805 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -91,8 +91,8 @@ Description:
 
 
 What:		/sys/bus/cxl/devices/{port,endpoint}X/parent_dport
-Date:		October, 2022
-KernelVersion:	v6.2
+Date:		January, 2023
+KernelVersion:	v6.3
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) CXL port objects are instantiated for each upstream port in
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8cea6df06bb5..410c036c09fa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1191,6 +1191,7 @@ static void delete_endpoint(void *data)
 
 	device_lock(parent);
 	if (parent->driver && !endpoint->dead) {
+		devm_release_action(parent, cxl_unlink_parent_dport, endpoint);
 		devm_release_action(parent, cxl_unlink_uport, endpoint);
 		devm_release_action(parent, unregister_port, endpoint);
 	}
@@ -1221,6 +1222,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, CXL);
  */
 static void delete_switch_port(struct cxl_port *port)
 {
+	devm_release_action(port->dev.parent, cxl_unlink_parent_dport, port);
 	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
 	devm_release_action(port->dev.parent, unregister_port, port);
 }
