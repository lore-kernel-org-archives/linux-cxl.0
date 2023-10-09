Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC491358B0
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU8/bw2B"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8671A4
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696876795; x=1728412795;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s9ubLW1mCTvshsTyelV/Z3LgwxU7aUPk+kS2OfoK57s=;
  b=nU8/bw2BKPunLfCj2aKKvA8YW1xzWlaj9Vug1MDLRVRxaJ2T02upuV2U
   yba8kK78tG9H5kW068sU6pDR8hchHPm53VDXlyoUhVTxQTS4Be7F56AL1
   Gep/+JNYVcta+eBNHPq/uPE3Ma157+bXFRNsRAFOHNVmDhUaY0ydcyFRa
   03YdLzYHcBV6QSH9VmNofh/7tKGhblUJLh372WSsekibOw6P4KpGq/kAB
   aotqMZ+O74iD/ckvxWKPMjAFDRmpvyGPdhx2GSvLz5UeMQmlate6yzrPd
   iH0r+/xpUeax7nfnlrqeiVeSYEM3LUQAmrkI7vJC/7kokVrfxHR8aHvVY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="384079639"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="384079639"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 11:39:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="756804648"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="756804648"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 11:39:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 11:39:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 11:39:50 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 11:39:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEIp1u6+daFWVzOd4rHdZe6mnmjYOLzHfBf+b6a3W6Rl9PglrwIZS1LCToekCy0lE+h5Yeg/RjGT44GIzZ6Zuw+gAbVmZKw1vBpm3AlYjKqN3FoNs9mFWGw+mfZfCfp3yfWc/gHMdUyihZm7s17lnynQZqL59m8Gi0UoA3miTfdpw6zi+fYjHvxAf9d7lTkuvU5Eiz1vWGzMqDfiJ8auoA+lfPakhWc5cod3zvpxM4YH6Rdu3JqbIcqquaVuSSqQorrX7ATbeH2F9nwvDfWw7zrojoGQw2XiQ3+HlnXFYd2t5e4yuR+U34oUvt53q3PbRfWCf2Al3bn+Df5YOtXa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukVD/h5i/ZvL2AOsO7hrzfdh9HLNCjL8yxDNv1e2iHY=;
 b=mOsSNAb/wNNWTIiI4TmrV3TqDdJyO+n1B6Jq8DrAcsMuPCrjB/4gpE5uBhjDX3cKLHVOpHJDwTJqRgOkHF7Lmx3QlzULwC+vfrBoJwAgclI8Fh5zREnolka6sFqZNNakw9LgoPCExglgpqmz1F0IlD2GMSE/bGXl7B2V1mf0q2AO3ufIl2bzldY7nPuDY5BQ9nBcOGpwMc6+AwZ+TMxfc32fcTLpIrBZuh+Bj1R3V7be/f06B1W/lDzkB5eXEb+zxy6OgsM0tgEWvWxkWQeM7XELqI5tHgA6N8d57reINrXPZ3ATLrv6mCjw5z1eW9XzeLfdPR7cA86B1/Ymbc+WuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Mon, 9 Oct
 2023 18:39:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 18:39:43 +0000
Date: Mon, 9 Oct 2023 11:39:41 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 02/10] cxl/pci: Cleanup 'sanitize' to always poll
Message-ID: <652448ed101af_ae7e72943f@dwillia2-xfh.jf.intel.com.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657717034.1491153.300696666588880104.stgit@dwillia2-xfh.jf.intel.com>
 <afq4tt4xhgecfhhi2k3hllxn3lj4j6j5tl6seknxp7i4xurjb5@vxgvams6smni>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afq4tt4xhgecfhhi2k3hllxn3lj4j6j5tl6seknxp7i4xurjb5@vxgvams6smni>
X-ClientProxiedBy: MW4PR04CA0178.namprd04.prod.outlook.com
 (2603:10b6:303:85::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 59204c40-a737-42cf-820d-08dbc8f71a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ac1puTXzhrVk4LGxn9azwDQtWpp9+PHc7kY1fnPByC+t4nemW6YBaIqDj32jSdgoXsgBOjbkrnfOZjhV/EoWozUElgWuRH3Fk1ab3sAHtTCfIATX9AcuCVemWakOOBEUbn7Gx6OA1L8yCNjmmvmmi26S4SPWJOliFZyOffXQku5mpdYK9QLzyFcvhDBaZD300PN8d9ixv8MhZOOBD7Hj2RHabVbKfbIj1kXaGBCgJ/h5hm8LIWLydeG9ADITIJ/chiDGkl2WZZ5aBIvTmAPjyjzR/J5hsy4voDhjih6OhXsX5YrBuAOhgnK3yMLdJoE81/AEybdnYnNfKiubbUWj8QCs3QoHZAQ7ErQybRY3LI2sw3K12HGSiqTd2rp3Nwq6fbbBtIxY485I2vym8Kk13Jf1hbf3CGHO5iCQotp27SN0tg1qHx9GhJsLAlqoWQwWuRx6sZ/MdIiVpOo3ab74u3iEHnqPNzKnMYXREXCzxh5tnFytUcrFDZD6LfZnZLyZ0TVRrlcpiKDLe3bMNrbJUxnhHdLo8PEoJfQUuzZYx8ep8tkmXMeIA0z9y5Qu7KMr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(54906003)(66946007)(316002)(41300700001)(6486002)(478600001)(66556008)(66476007)(2906002)(110136005)(6506007)(8936002)(8676002)(4326008)(9686003)(6512007)(107886003)(26005)(38100700002)(83380400001)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2fFnWgTxg/IeRmh9l1u46byDuuboHRef44Pn1LP+qi3OerKBIVKd+V+Am8T8?=
 =?us-ascii?Q?TOYt1hK7iHnOKk3I4bIGXdFgV3gtSJ6inhhFp/dlLnfXcqyh3IIplhG5Lp2H?=
 =?us-ascii?Q?Ec435iUuhIFcKzYjp95onBOu5cxd8J3Gip+QNWv/97K3VRC+G2mrIMBEHRP6?=
 =?us-ascii?Q?ynZ9pMLFipATTig5ye3x0un3pO/TpV/guIyrQTh9Vz/oLMADiTdOAjorGAcT?=
 =?us-ascii?Q?5sIuo7LIfs/eOLhjV2/UCRisjdlLGc+keGV3EEzAsGeCs2hya5z4Inr41k0D?=
 =?us-ascii?Q?fqRe8xarFZwoQjWeLDvztrLFZiE9vZgaBNjzX74kAt1emGdRar2vMUc+UItE?=
 =?us-ascii?Q?cO9YWbpkb0IsSjjTpw440+Lz0qMfFbgee803yM4nFomnOThas7+x0blQgmmp?=
 =?us-ascii?Q?C+uNqXcsSR3WhFqamR8hVBa2CAafLlwxSj/NcQm91HBMxCVQNvtMaWx0iRpU?=
 =?us-ascii?Q?PCgoaooD44WrBus9yD4edEOwnEunzn1NAe5KZYWB1dxr5Xh7QsHkm9X/rnht?=
 =?us-ascii?Q?6X7ZGnxqKXsAwnUkum5ZIj/zl7AlU8QWhDQXabjIpehlis1+OILQgmvg/Oqx?=
 =?us-ascii?Q?vbjRskd/BdJKxgUptTGIOmlC1UQAnK6VM7dJv0LwpOK1gyxhc5O2VZ7E8wih?=
 =?us-ascii?Q?GR8e5KLOlTEJ5H83UMrNUyN1Ke9TbUk6tentNtE1g/794w0CFGy7cKyco97k?=
 =?us-ascii?Q?jcK8DcP/1XbO0cT+kuX9LEmxmNLjg4U+dkRRR+T1I0geKPa8T1Y3JX4TGzji?=
 =?us-ascii?Q?Ox07ibZ/5IrWDg+1HUah9CvwkUPZMZkPuBKl46+44jnGhPn0cWNtsomzs5SG?=
 =?us-ascii?Q?83q9xkdydmnsU0cJry0oNs0pJQEBmKeaGRRzWHha4pDQR1EyVjXcl4WeRUTl?=
 =?us-ascii?Q?B8gseaZMoU0NH76nUBPbmo1MyLJ1N2lckNNXcemp/ax5BfcByrRNk3JHmFAL?=
 =?us-ascii?Q?Z87U8SLZXqgvvXdbwI+Lu6iFkzVef3zJEWToa62Yrr0yNG4gZp8knAdgJoAQ?=
 =?us-ascii?Q?Sncgp3a5ObpOoQN/P5MUbEsVggz8QEDJrMP4/pwe9oHS5gQxJbVRH1es1w88?=
 =?us-ascii?Q?HNONbjzKvuYCeoZnWQYoOhmkQVHNhokAYgs05C8Kr7j/jZ4+dZorXdpSWy1q?=
 =?us-ascii?Q?xUg2T+kJan4HM1OENwrDeEHsI8F2LH+e2FFupIbj5uz2iIla5STAqrIjot6i?=
 =?us-ascii?Q?dFCkP04V67gZjVU5/FAXEll1YDNsBzAOlfl29wsVJP4cEx+UYEdXFfb2CdH8?=
 =?us-ascii?Q?1yMraobsckitzh9IlgTgBzluDesiewFBj94yBDoDcb+jtrGKhvls304yH+Ze?=
 =?us-ascii?Q?DIHqX4rzfZcbZKyeUuZ1lvMlMS6/tz1zSDYu401Lb0AKXhrSF+/AyDVhkGYI?=
 =?us-ascii?Q?Wk+UDQkC9Km1cn/2mnboKxV0UBBM5U/cz5Y6CDr7/I8LC+6fiCX15uo3pLcM?=
 =?us-ascii?Q?Y3/PaQ2/rxGwS400Rq//oQs72Lx5rHsp3LcSBvDynZldhQrb7z4IKQYRj34+?=
 =?us-ascii?Q?cx6rTxL+erst/MAcQdr4s5pIQ75Cc0AD/9hhL8E8Gk9Sr7TuZW7rQruJ2Job?=
 =?us-ascii?Q?IkoChZ4vUjbbjaF9gEX+Xzb9TlqTmqYwTOWPP9TXbvsHeoWvsVfxkSc1F1wD?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59204c40-a737-42cf-820d-08dbc8f71a7e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:39:43.1329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA0Vibr11BMY+tQYx0+nQYxNaMuOaJTjK45JX/ICjl5TE4GADMM7MnDD/+VCzs38s8+JAkQbrYYkdKnFvexYtb/FuJjk3/Y1vTUpRyQDWho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Davidlohr Bueso wrote:
> On Fri, 06 Oct 2023, Dan Williams wrote:
> 
> >In preparation for fixing the init/teardown of the 'sanitize' workqueue
> >and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
> >to be the single location where the sysfs attribute is notified. With
> >that change there is no distinction between polled mode and interrupt
> >mode. All the interrupt does is accelerate the polling interval.
> >
> >The change to check for "mds->security.sanitize_node" under the lock is
> >there to ensure that the interrupt, the work routine and the
> >setup/teardown code can all have a consistent view of the registered
> >notifier and the workqueue state. I.e. the expectation is that the
> >interrupt is live past the point that the sanitize sysfs attribute is
> >published, and it may race teardown, so it must be consulted under a
> >lock. Given that new locking requirement, cxl_pci_mbox_irq() is moved
> >from hard to thread irq context.
> >
> >Lastly, some opportunistic replacements of
> >"queue_delayed_work(system_wq, ...)", which is just open coded
> >schedule_delayed_work(), are included.
> 
> So the current order of this patch will cause bisection issues -
> the next patch which moves the irq handler to a threaded context
> should come before this one. Otherwise:


This patch does switch the order:

@@ -432,33 +429,26 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
        dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
 
        rcuwait_init(&mds->mbox_wait);
[..]
-               if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
-                       goto mbox_poll;
[..]
+       if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
                return 0;

...the next patch only deletes the option to pass non-null in the third
argument.

@@ -440,7 +440,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
        if (irq < 0)
                return 0;
 
-       if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
+       if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq))
                return 0;
 
        dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
@@ -638,7 +638,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
        if (irq < 0)
                return irq;
 
-       return cxl_request_irq(cxlds, irq, NULL, cxl_event_thread);
+       return cxl_request_irq(cxlds, irq, cxl_event_thread);
 }
 
 static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,


...did I miss anything?
