Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C0328A6
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hH0H53Zu"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82426C5
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696614832; x=1728150832;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ejzA3DE5NTh2pqza6ky+19xLQyv8Pa8rB1LTSbCjFiQ=;
  b=hH0H53Zu3of7DmB34KkrTKnXje1zo+N8dUMJ5VgzE21EEJXr9aNpSra1
   MjjYa2c2Ytr/mVHHbkg+bEvnX6eZYXomAbS3O4BU6+9uQYWHukZxIF9ec
   7KEpELyILLy81RFW9tOoXUZkm2TeK7WRpkBobU1mTLIYlbW0S0bX9hEct
   PQmVoZ4rWa4rCB8+vFhhspZAJw0/i2NfoRiuMuVY7Fvhp6c2SsPVxc9wW
   AoUGWAjHSRuNE2WBrymV1ytPO8ZADMWWvOLSMnL84gglFpQhz1Wz2pkev
   IRj2bwfc7hkqQjZcAH7PYGI8qwWbN6EI/33+nd3e+faZuosMlFTcPLei7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386624425"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386624425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:50:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="728916892"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="728916892"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 10:50:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 10:50:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 10:50:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 10:50:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vlgn1wTioogkP0LbDDK20pcJobBtqlAJGZyXka8exUxh/C/pPeZ8ZuRAyQSTOFeTyJN/+Sm8UKVYjwqgS/UQSKDWjc7Adf6Smiayxq3edtwPrCozQKtc7R9GI6XUCksnRP3iZaT056FBbVNY8tlYIqPpTbrIvX4tT2zUI9ARVeWaOEdDVCcZ7DqeL1ZaSvus3QAGVW9Zuj+6Gh0NkrCdhSnG3b7cxdAuj93Uqm4Jp2dMkGrtQvEhWFELyYkeGq4WvqaVvQdn0x4xA+aWPWzO+wAGgMMcdgxKPawDq485gz4soDlocmi4hBxvt70uJ+CKisLTS8+pYZU4yCAj4kHRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD2XXCOLBzF8f+DBPNjEGutmhBMEU82sl7ljBTvGmRE=;
 b=EmnVIqHos1JkOPA6XipXBeQKsR9Ku8yK+73UsO1JTPySeud0lrnu0IEyo60DTEUnJEDjIdmPccLGvEkreiH36LgcvZHZFwNnJa6bJf0EmTuAwjX4v9ZpGSn70DhjNO4ANbHs06TZxJKQT/wphP/CtVMGKrBxvYPcoMQvxjf1GO7Chn/L9KhpRzmDFlAl/+BcJjCpPwz7gn2feQk0fGQx3Y/U5ZAaUHsOp+PZEUEV1ut7hoy/KcalHeMHB4SV602zNQPcbsj7sIvrbTvyTznXujSnYfkS3W/krv5h5uodkbZgymwQrOYNk/AGpjKfSrIwGELKDjzM6V3C8TDaNrZSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6814.namprd11.prod.outlook.com (2603:10b6:a03:483::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Fri, 6 Oct
 2023 17:50:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 17:50:31 +0000
Date: Fri, 6 Oct 2023 10:50:28 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: Dave Jiang <dave.jiang@intel.com>, <thuth@redhat.com>,
	<qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
	<anisinha@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
	<richard.henderson@linaro.org>, <eduardo@habkost.net>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <652048e465c8d_ae7e7294e9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231004180529-mutt-send-email-mst@kernel.org>
 <169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
 <20231004230132-mutt-send-email-mst@kernel.org>
 <12874c03-7de0-474f-9378-7d3ab8572d8d@intel.com>
 <20231005122736-mutt-send-email-mst@kernel.org>
 <20231006130939.00007a69@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231006130939.00007a69@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0202.namprd04.prod.outlook.com
 (2603:10b6:303:86::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 74fe8cae-8926-4546-9c6a-08dbc694bb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CM99/Mio92wLkoZzv+DMVx6lJajr8oJY1qPYndQaDrPHvRY1V6aFnAfUQPmaHf2RNYv7uXwMLdfYdxwK7cfU8TJZuumY6nnRbV+euTSZfXb33fP3pautYijxJ2pWroycJ8c5abZM2qYO1fm/hXE8S+keI7k0vlHgv1E9RTtkvd9ajZ1wjioqAnldVFzeyDDUHC+mWd3Qex13Sl731dDFNOrQCTC4mp5IiOtD54XmKUUGR8uNbthCVmnb3xyJPgT1tuZRWKCM2YCSKe2hvLe1O9R803w9TnA/Uo5H9xKKXbm3o3vX5a4KIDq4R+gbjt9mbKCKAntyVV2t2iAHvBGyVF5BRhq42kZWe0ZZL30LS0Q4eJeQk5/VLNbquOVVruSgIq4hg/8EOdt8Fisk0weHKzPkrQvPTBttrPtjRuQqCCZjSKfHqW4hdhz4qzgPdr+tK/RT1V1tIau7xvTNI3YUmhedB1fDk6nUd8PektBJcztSA/OnX7axD8eCW92tfhptKj4ODk+cPeVaphwMGcrEPFnXEycC9PQpi0VI1fsRCvKx3F9E/m6Qyooenr0oO3m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82960400001)(6506007)(6486002)(6512007)(38100700002)(26005)(9686003)(110136005)(8676002)(5660300002)(41300700001)(8936002)(66476007)(4326008)(2906002)(86362001)(7416002)(316002)(66556008)(66946007)(478600001)(6666004)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?reX4E+2RXIAvL4WPX1aHzPb5BXfiBVVmiORUceSVE2UaxVkAdpby+bcPY9HA?=
 =?us-ascii?Q?T5foxTivXJLB+1z2/J1FgSlsLrz+7mQ8OclmzlUz9n5rFcRNwbe+mvXKt1ny?=
 =?us-ascii?Q?KVXrbSUq6VrXSZrOzmUSNb8LDYqaoD7sCTc0taPTfAKgL+L90YyhPRW/nLiQ?=
 =?us-ascii?Q?cSS6pcVynlzQ5A+lZX/+R++t6UXk2ptXbxjG7BWl2MnGR8dxIcTB6ve8ZhMx?=
 =?us-ascii?Q?0CQZiOuM1sGaY1n5vt5W9tWFkEDO4Os4dRvxGDjSCrN44GsegG0LJ9R02a6j?=
 =?us-ascii?Q?IVBQWGixuZng+WGBszdd7wyvT9HVwDrO0H22zXopszuDYHOF5OcwozXVcmCl?=
 =?us-ascii?Q?4fgkF2JfLhJG3QFh7oRP7d55shyZ25S0QCvMvUWC8v0P8bXzdaB4J4JrGzju?=
 =?us-ascii?Q?UQopUOIPXxkJauCWSNSux7bLI7DXOxZIG9vgipD08oypNZtHyoqWH0rnaiDo?=
 =?us-ascii?Q?rbiieYYo9diNj65JmYDe0lgdEjYUHHWfUQYzNrU5x6EVJms7M5pS7UnlUqc9?=
 =?us-ascii?Q?+s/YakQPmpm+b7GiTGV/m1qvv6XkioTiaAvPMG5Gm3PL3NnTo8f7Crhe0X03?=
 =?us-ascii?Q?A7wwO3V4j4LnEWO0Mt7l0DsC08pJ0PYH1g5r4EqPRmPWZ70CZAexb5mbhnQt?=
 =?us-ascii?Q?jdM3hdX7GTr8d25eV+apU0tJ2SzTKSR92sbM0G1mM499gYk8A2i8m1jtVr6J?=
 =?us-ascii?Q?Ufu4S2V2NzchPqzRJcqhQiX9w8Souu7fgeKDC/jR9bCOlmtTtYzz5nbtMVu2?=
 =?us-ascii?Q?ZQUXaKnm7TpTxLLlyuT9YfD3Xou34cX92nvtiP1ZVTZ5We7Y3xg9zLpwPl1t?=
 =?us-ascii?Q?zx7Fj5wFQHIkK9kvmVDuSz8P7/ECXJX+90S4VLulqAhi3vJUES769s7ACh1l?=
 =?us-ascii?Q?xoTctAm3hzTnnD916udixfLIZDMeq+rVGV2xcI7MZ39+h2WICj8u9Yv33BAG?=
 =?us-ascii?Q?rqmFXKTxk5DqdY0Yq4DwD5YE81j57kkvTB7Oqk4jQ1PCFLEspx2jjoMAR2iv?=
 =?us-ascii?Q?vvMpVR1f0LUOvEWdC5rFelfA5Hl9iVLoxC8dYVllh/gZjTv6ElXxMtCj7TeF?=
 =?us-ascii?Q?YrKs10VNu45agylsrp0v7JzHT7sGmrX8uJoSBRa6DCa5er4uCE25PRhUW6i0?=
 =?us-ascii?Q?M09pYTto5TCXRDlwDYEcwXTFw0lMu2cRdIrhhpJ75u87m+65xde8L6bi0c2v?=
 =?us-ascii?Q?HlBruY8j23ipwxUFAUSsZdqxk4CIwHo3LEe7M99x7M9dS6BXdHpw71yHENlF?=
 =?us-ascii?Q?bD/BD5Fgc35aQ2V+wK8WrC6SUmh/qUKdw8TAeGGdmx4ZUWZGF3GCp2alRvS3?=
 =?us-ascii?Q?Nzu0Lqpk/eMa6M4JdLY1SllfSe5ifmoZZ3GVeF3SzaVJcNF+Bsh2wH3M22CF?=
 =?us-ascii?Q?aSmY8lXVgSwEjxTeefUWc3kKUVyYM3E0qcYroTFLtULWixDRQZImjt6lANQe?=
 =?us-ascii?Q?VW+Ft3N3FTfCceCR0ykWKDXU+mivhKLxuG39FiKvONs7NBHkl0BzgiN29vft?=
 =?us-ascii?Q?7aqxKaTfsw3d1o2Z6lE/Jv5BN1wjgW1QevIYrZFwj5YH0oJ1ySBOyu+zq9f1?=
 =?us-ascii?Q?2JGEH/dfYaWo5c8BuJ0Iw8Fh95F3SNFzMXe1h2CFVG+Ns+dSlC7lQAA8v3X+?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fe8cae-8926-4546-9c6a-08dbc694bb81
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:50:30.7461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBVSrd2cYaQNl2oPc0e+/Tvy5XzpHmt6NCqPntN/cdeQAUFX8WJi9yov9IeffwFAahZWYJuyRYKbroZwhVevnuAr3HvDvHBN3XtpQ1VYyuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jonathan Cameron wrote:
[..]
> > > > 
> > > > what does "a WORD" mean is unclear - do you match what hardware does
> > > > when you use aml_buffer? pls mention this in commit log, and
> > > > show actual hardware dump for comparison.  
> > > The CXL spec says WORD without much qualification. It's a 16bit value AFAICT. I'll add additional comment. Currently I do not have access to actual hardware unfortunately. I'm constructing this purely based on spec description.  
> > 
> 
> WORD does seem to be clearly defined in the ACPI spec as uint16
> and as this is describing a DSDT blob I think we can safe that
> it means that.  Also lines up with the fixed sizes in CEDT.

I am not sure it means that, the ACPI specification indicates that packages
can hold "integers" and integers can be any size up to 64-bits.

> > It's not clear buffer is actually word though.
> > 
> > Jonathan do you have hardware access?
> 
> No.  +CC linux-cxl to see if anyone else has hardware + BIOS with
> QTG implemented...  There will be lots of implementations soon so I'd make
> not guarantee they will all interpret this the same.
> 
> Aim here is Linux kernel enablement support, and unfortunately that almost
> always means we are ahead of easy availability of hardware. If it exists
> its probably prototypes in a lab, in which case no guarantees on the
> BIOS tables presented...

From a pre-production system the ASL is putting the result of SizeOf
directly into the first element in the return package:

	Local1 = SizeOf (CXQI)
	Local0 [0x00] = Local1

...where CXQI appears to be a fixed table of QTG ids for the platform, and
SizeOf() returns an integer type with no restriction that it be a 16-bit
value.

So I think the specification is misleading by specifying WORD when ACPI
"Package" objects convey "Integers" where the size of the integer can be a
u8 to a u64.

> > Also, possible to get clarification from the spec committee?
> 
> I'm unclear what we are clarifying.  As I read it current implementation
> is indeed wrong and I failed to notice this earlier :(
> 
> Ultimately data encoding (ACPI 6.5 section 20.2..3 Data Objects Encoding)
> should I think be
> 
> 0x0B 0x00 0x00
> WordPrefix then data : note if you try a 0x0001 and feed
> it to iasl it will squash it into a byte instead and indeed if you
> force the binary to the above it will decode it as 0x0000 but recompile
> that and you will be back to just
> 0x00 (as bytes don't need a prefix..)
> 
> Currently it would be.
> 0x11     0x05 0x0a 0x02 0x00 0x01
> BufferOp 
> 
> Btw I built a minimal DSDT file to test this and iasl isn't happy with
> the fact the _DSM doesn't return anything at all if ARG2 isn't 1 or 2.
> Whilst that's imdef territory as not covered by the CXL spec, we should
> return 'something' ;)
> 
> Anyhow, to do this as per the CXL spec we need an aml_word()
> that just implements the word case from aml_int()

If I understand correctly, aml_int() is sufficient since this is not a
Field() where access size matters.

> Chance are that it never matters if we get an ecoding that is
> only single byte (because the value is small) but who knows what
> other AML parsers might do.

I expect the reason WORD is used in the specification is because of the
size of the QTG ID field in the CFMWS. ACPI could support returning more
than USHRT_MAX in an Integer field in a Package, but those IDs above
USHRT_MAX could not be represented in CFMWS.

[..]
> > but again it is not clear at all what does spec mean.
> > an integer up to 0xfffff? a buffer as you did? just two bytes?
> > 
> > could be any of these.
> 
> The best we have in the way of description is the multiple QTG example
> where it's
> Package() {2, 1} combined with it being made up of WORDs
> 
> whereas in general that will get squashed to a pair of bytes...
> So I'm thinking WORDs is max size rather than only size but
> given ambiguity we should encode them as words anyway.

My assertion is that for the Package format the size of the integer does
not matter because the Package.Integer type can convey up to 64-bit values.
For being compatible with the *usage* of that max id, values that do not
fit into 16-bits are out of spec, but nothing prevents the Package from
using any size integer, afaics.
