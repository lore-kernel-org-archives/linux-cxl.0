Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741C2C0015E
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 21:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjF0VNi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Jun 2023 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0VNh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Jun 2023 17:13:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2077.outbound.protection.outlook.com [40.92.53.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3711727
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jun 2023 14:13:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv+eRzDK+TO8zNrmGPl3kkvq8YPf5Di+bk2E8dSvmyd5vwpkIztvmFZWdQCQ0x2wnuFq7NQRA54skHrdkSJYLcqYyunOpyjz8J5G9hk6QX034EVDeq/7UwjP5T1eXbS8waZKJs6uxyU2LlIKXW7qqwprc4G1FeS3JHCzmvpuDY9nKT7QDhW2S0Napzljf7I65NoJu+YXH0X1k/MzjB8oLg1WwXzIo5N9reabw4j8v76kILPwEFpO41bXDg3FZPZKE/bnLei6eewjkkWybES2vFNLLYoFNNsJGyxEputaWLg1oHKcicAqflyD7XzRVj1qrPVKgvELV7sFthrmqM0x6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPY0i+3Ql9GaudCLSxnhBBbxj3eUUJ6eSyTLn3A1tlc=;
 b=FyZP43oPMDRqohGhGuQuwBWopk4t4hX4kCG+XB0Zx06snHwo3/TyCyyZ3IxyQWJ8TU1lPATwu+j/Jn+86yLt9O5+5/1DN8y+dN9FcAfehRJurEF2/bulPHR+gviDVLl25WfwgQD51B+POzgf8T2/533xKRI0C9UOQdUCFuCpDx5+8gvzLJavu+oya40kRuvbXm/+KIBQuBrLP/JB+8LDoDGnjkg+Fj1//Z8+QCsQWA/ww5nsHAgmpkPbQde2Q1sZnT6IEL0sVNQ0RlDhlPEVRwaNFctjxG+N/1gLkg5l8ScWr+rYuQ1kTbqden9wo1Vyun08v1tvno3CF802QMc/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPY0i+3Ql9GaudCLSxnhBBbxj3eUUJ6eSyTLn3A1tlc=;
 b=Phni0p21qBk3sehoD2KD0rBN6RWXDySZuxKtY1BW6d4PDUWqugg5pT32rzKfG7IM+mz4uzAhUo/zXF5EndyCYt9SFBXbq69rGv0r4Jc17HI9wk3wDt9ic8QBEPw22L/Hs1VtUqFzT87Hm+oYFApeq1EEIeejks0ixOBon4Nwd0Pf22Q+AC62NXnqBOO8IzZL9qkWSHKScpGZSBFAjZv0MK+mvInMcKJygoDHr966H56FrrhRdmw7moIH9Wb+cRNMSWOALbRfrbqo7dqS3mXxF8vxMLPZmBLYDTvJZsolMru3EBiw9T4daaF0TeQ/Mjw9umB5dz7fXEQDMvPgATAveg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SI2PR06MB4266.apcprd06.prod.outlook.com (2603:1096:4:154::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 21:13:29 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 21:13:29 +0000
Date:   Tue, 27 Jun 2023 14:13:17 -0700
From:   "nifan@outlook.com" <nifan@outlook.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Nathan Fontenot <nafonten@amd.com>, Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [RFC 2/7] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region
 representative and mailbox command support
Message-ID: <SG2PR06MB339789E75307E3B63C5EA83EB227A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
 <CGME20230511175641uscas1p165a19a1416facf6603bf1a417121f0dc@uscas1p1.samsung.com>
 <20230511175609.2091136-3-fan.ni@samsung.com>
 <5cf2a93d-1a20-c87b-5276-69feb5056e72@amd.com>
 <20230515145835.000076b9@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515145835.000076b9@Huawei.com>
X-TMN:  [NcAQuERlHtMXeXdFbng+oQWVzDWefKIE]
X-ClientProxiedBy: CH2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:610:59::34) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJtQ7cP9/KBYNCy2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SI2PR06MB4266:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f7bf8f-0381-4bfa-2244-08db77535a99
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONHsVujR0+Cf+nInIyhxB+NsuqzKXKR2EO0/6hjfV5B083tdh0QWD1oWkRFkLNa+ym23lpHk5Jvw1spSCstN5jtz4+KFyQZ8OZeCWRz7OOwUVJHhyjaT16p0Gl5ihrlAQxloqyJOb55Yny39fI5BSA4kVqQJPdcoRYqRY/GhpnjNK/+WwBJwRTNVTU3VbK9tVn6NvZaiaIMyS3P+ZJNrDbLP1WdfDdiTHmzTgdnoZbk0qjGMo4XsJvoWPGFZ+Lngr42O8uWAeVhPIdadWTMTFca3f99rdZvrbdf31smMCqB4Sy3JqtOVrCYWk+dNpQzMnrE3jA/mK+7Fa9EUWGQCcoVjQ5x32i8BtSBqVHgTj9JUglb9v6FBV/Dnb0mR2oBu/JJzXNn/8xbklG/GLyVmm+t114h4pL/gmP/X8xQybD8jbQoGQhh60ybQS6wWifKMCZV5r6TlJ9HIOurSX+m75QcOzY+dbhyDJssrc7lASRErT7BPoxvF3s+xv1O0Bml+WVLxSHGwFMRJzukHOBE4Qd45TDbhApum7GOAOmxLF9/gMmb+ffC4FbEvPUIKtdIX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZQY2V2emNObThNWmYzWGJtUlgxWDdEWHc0OGR1QWhOZFVrRzhQbjA5S0V5?=
 =?utf-8?B?UjZNaks1Y0o2N3diaTQyVTlFeWlPQklBTVBNRXQ5dS9YeDQrRkhmNDVWVVhD?=
 =?utf-8?B?M3VQQXIzcVJpQmlXTHBDOTdNRThoTEw2OENNMGsyQm9BbzdZK3pwdnA3Qmxk?=
 =?utf-8?B?UDNyMi94V0g2UzMxNE5vUXV0TFBNalBVQ0J3MnZiMDNBWGN6dTR6NUtxUGR3?=
 =?utf-8?B?VlpIbEdHRmVwcW9WZGtLbmRSQnVId0VodGh3eWRMeUE5cHh3NnZoVW8rZTIz?=
 =?utf-8?B?YmVsdnhtc0t6alBCNGhUOU9GQlNBK2VIY0xOOVNsSlhWQ0N5dzBNV0RHdll0?=
 =?utf-8?B?Y2dGTWFoZ2JpSG9UN2hlTXdZQWZPcS9vb2N6MGpjSFkxNzBPRldydC93ZFFy?=
 =?utf-8?B?TW1mQW0xRXdvci9saE40Q01aTVZBOU5udzM0U2NEZ0s3dUdlbHBIZ0xXN3Jy?=
 =?utf-8?B?MjhGQ0d6dVI3aHZzTlpRRSs1U1pyWnVxcXliSUZsT2tsVXdwZUhsS0xsVExK?=
 =?utf-8?B?SytobW9LWld5bVVYem1RUGt3VWVyY3NZMVR0Zk5taGZpa041bHBxczVua0VF?=
 =?utf-8?B?c3dBOGxDOWZWZVBxcEVZRjVIVlljem9BN2J6cjlpb2haSEtHUkRHeEo1dmVW?=
 =?utf-8?B?SDFqMk05V2NUTFpXZzlldk9WMVhnWEZjZ3RDdGZEcitVVWJZS3NYeWhoM1Bn?=
 =?utf-8?B?eEVUSHBZazAyZG9ZR0pxcXdyWis4a0VEQXVCdnlOdGF2SHFMYkxTY2ZMNWV1?=
 =?utf-8?B?TTByL1EyVUZITWVzcWpYNE00TGJWMzMwT2N3eTc3NkUyUXpmY1NiSU13OHBz?=
 =?utf-8?B?blJmWWN4MUQ1eVBqK3kvZHprc1ZKc0dwMTF1TXEvMEp3eFB1U3B6SmRBVUtq?=
 =?utf-8?B?SWZrc3pVVmRUVnV4S09aSmZMenRrcjhEbkRhODd2SWxFc0lQUUJqM1ZjZ0pE?=
 =?utf-8?B?ZERDZGxGazdDWjl0NzdpeFQ0Nlp0QXZGNk5LaFc3RzVPU05GQkFJNlJFWXMv?=
 =?utf-8?B?TXYrVkNwQlBUKzRWRmlQNTIyZkNQZEF4MStlNHlxOG5oN1lYbXNCcm83bEM2?=
 =?utf-8?B?S1BLOW9ZR3lDajhCS2hYVkI3MTlUN2YyTmRuOTFZTTdWYm9uSTJrMkpmbUw2?=
 =?utf-8?B?VmZYd3NlbFU5OFdmVkZrbWNwZkpmcHpiMi85WHpaMVRvNjVYdWpMeSs5anZJ?=
 =?utf-8?B?SkhHRFc3WEI1aHNqN09nUUxKazRzd3FVUnZCSXNSdUJVcDJPbDY4VjJpVmc1?=
 =?utf-8?B?MDc5bFc0em1yTnNMcnc4Yk5ONW95RVY5RFhYZGxXcVk4alRXZzF0eXJJSU1t?=
 =?utf-8?B?ME9TWDZray9YSU5qblRBZkFrMDRNQlI4KzZiRmtxVWJRZTlScEY2dElKNXY4?=
 =?utf-8?B?a2l4bWNOUWgrMWJZQlp1dnEzWEVTRElLSlE1VmdsOFAvVzF3bWpPL05lQUFY?=
 =?utf-8?B?UmhRYTdyQkJEUWtTS3NnOWx5QjZSck1teGFlZmpYMW51elhTRFNZT2M4cllL?=
 =?utf-8?B?ekU2N0F6YkwyTGZ5Q01wc3BrWW9IMDhSNUgzSHRpVEtteW1FNUFSSHp4d25L?=
 =?utf-8?B?emRVL2cya2wxOElKUFBpNkI2aWFpWmlYMFhmelFQSjZnWnVsK2I2OWs3c1NZ?=
 =?utf-8?B?cndmdS8ydzk4b0J0U1ErVm54L2NqK0E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f7bf8f-0381-4bfa-2244-08db77535a99
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 21:13:29.4858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4266
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/15/2023 14:58, Jonathan Cameron wrote:
> On Thu, 11 May 2023 16:53:23 -0500
> Nathan Fontenot <nafonten@amd.com> wrote:
> 
> > On 5/11/23 12:56, Fan Ni wrote:
> > > From: Fan Ni <nifan@outlook.com>
> > > 
> > > Per cxl spec 3.0, add dynamic capacity region representative based on
> > > Table 8-126 and extend the cxl type3 device definition to include dc region
> > > information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> > > Configuration' mailbox support.
> > > 
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c  | 68 +++++++++++++++++++++++++++++++++++++
> > >  include/hw/cxl/cxl_device.h | 16 +++++++++
> > >  2 files changed, 84 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 7ff4fbdf22..61c77e52d8 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -81,6 +81,8 @@ enum {
> > >          #define GET_POISON_LIST        0x0
> > >          #define INJECT_POISON          0x1
> > >          #define CLEAR_POISON           0x2
> > > +	DCD_CONFIG = 0x48, /*8.2.9.8.9*/
> > > +		#define GET_DC_REGION_CONFIG   0x0
> > >      PHYSICAL_SWITCH = 0x51
> > >          #define IDENTIFY_SWITCH_DEVICE      0x0
> > >  };
> > > @@ -935,6 +937,70 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> > >      return CXL_MBOX_SUCCESS;
> > >  }
> > >  
> > > +/*
> > > + * cxl spec 3.0: 8.2.9.8.9.2
> > > + * Get Dynamic Capacity Configuration
> > > + **/
> > > +static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
> > > +		CXLDeviceState *cxl_dstate,
> > > +		uint16_t *len)
> > > +{
> > > +	struct get_dyn_cap_config_in_pl {
> > > +		uint8_t region_cnt;
> > > +		uint8_t start_region_id;
> > > +	} QEMU_PACKED;
> > > +
> > > +    struct get_dyn_cap_config_out_pl {
> > > +		uint8_t num_regions;
> > > +		uint8_t rsvd1[7];
> > > +		struct {
> > > +			uint64_t base;
> > > +			uint64_t decode_len;
> > > +			uint64_t region_len;
> > > +			uint64_t block_size;
> > > +			uint32_t dsmadhandle;
> > > +			uint8_t flags;
> > > +			uint8_t rsvd2[3];
> > > +		} QEMU_PACKED records[];  
> > 
> > Could you declare CXLDCD_Region as QEMU_PACKED and use it here instead of
> > re-defining the region structure?
> 
> Could be done, but care needed on the endian conversions.  I wouldn't
> mind seeing this always held as little endian state though. We'd have
> done that anyway if it was a memory mapped command set rather than read
> via the mailbox so there is plenty of precedence.
> 
> Jonathan

I will leave it as it is for now.
> 
> > 
> > > +	} QEMU_PACKED;
> > > +
> > > +	struct get_dyn_cap_config_in_pl *in = (void *)cmd->payload;
> > > +	struct get_dyn_cap_config_out_pl *out = (void *)cmd->payload;
> > > +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> > > +	uint16_t record_count = 0, i = 0;
> > > +	uint16_t out_pl_len;
> > > +
> > > +	if (in->start_region_id >= ct3d->dc.num_regions)
> > > +		record_count = 0;
> > > +	else if (ct3d->dc.num_regions - in->start_region_id < in->region_cnt)
> > > +		record_count = ct3d->dc.num_regions - in->start_region_id;
> > > +	else
> > > +		record_count = in->region_cnt;
> > > +
> > > +	out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> > > +	assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > > +
> > > +	memset(out, 0, out_pl_len);
> > > +	out->num_regions = record_count;
> > > +	for (; i < record_count; i++) {
> > > +		stq_le_p(&out->records[i].base,
> > > +			ct3d->dc.regions[in->start_region_id+i].base);
> > > +		stq_le_p(&out->records[i].decode_len,
> > > +			ct3d->dc.regions[in->start_region_id+i].decode_len);
> > > +		stq_le_p(&out->records[i].region_len,
> > > +			ct3d->dc.regions[in->start_region_id+i].len);
> > > +		stq_le_p(&out->records[i].block_size,
> > > +			ct3d->dc.regions[in->start_region_id+i].block_size);
> > > +		stl_le_p(&out->records[i].dsmadhandle,
> > > +			ct3d->dc.regions[in->start_region_id+i].dsmadhandle);
> > > +		out->records[i].flags
> > > +			= ct3d->dc.regions[in->start_region_id+i].flags;  
> > 
> > In this loop your reading from 'in' and writing to 'out' where in and out both
> > point to the same payload buffer. It works because of the structure layouts but
> > feels like a bug waiting to happen. Perhaps saving start_region to a local variable
> > and using that for the loop?
> 
> Does it work?  There is a memset of out above.
> Definitely need a local copy of start_region_id before that.
> This might only be working because of good fortune / compilers being 'clever'.
> 
> Jonathan

Yes. We need a local variable to record the start_region_id.

Thanks Nathan for catching the issue.

Fan
> 
> 
> > 
> > -Nathan
> > 
> > > +	}
> > > +
> > > +	*len = out_pl_len;
> > > +	return CXL_MBOX_SUCCESS;
> > > +}
> > > +
> > >  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> > >  #define IMMEDIATE_DATA_CHANGE (1 << 2)
> > >  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> > > @@ -973,6 +1039,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
> > >          cmd_media_inject_poison, 8, 0 },
> > >      [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
> > >          cmd_media_clear_poison, 72, 0 },
> > > +	[DCD_CONFIG][GET_DC_REGION_CONFIG] = { "DCD_GET_DC_REGION_CONFIG",
> > > +		cmd_dcd_get_dyn_cap_config, 2, 0 },
> > >  };
> > >  
> > >  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > index e285369693..8a04e53e90 100644
> > > --- a/include/hw/cxl/cxl_device.h
> > > +++ b/include/hw/cxl/cxl_device.h
> > > @@ -383,6 +383,17 @@ typedef struct CXLPoison {
> > >  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> > >  #define CXL_POISON_LIST_LIMIT 256
> > >  
> > > +#define DCD_MAX_REGION_NUM 8
> > > +
> > > +typedef struct CXLDCD_Region {
> > > +	uint64_t base;
> > > +	uint64_t decode_len; /* in multiples of 256MB */
> > > +	uint64_t len;
> > > +	uint64_t block_size;
> > > +	uint32_t dsmadhandle;
> > > +	uint8_t flags;
> > > +} CXLDCD_Region;
> > > +
> > >  struct CXLType3Dev {
> > >      /* Private */
> > >      PCIDevice parent_obj;
> > > @@ -414,6 +425,11 @@ struct CXLType3Dev {
> > >      unsigned int poison_list_cnt;
> > >      bool poison_list_overflowed;
> > >      uint64_t poison_list_overflow_ts;
> > > +
> > > +	struct dynamic_capacity {
> > > +		uint8_t num_regions; // 1-8
> > > +		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
> > > +	} dc;
> > >  };
> > >  
> > >  #define TYPE_CXL_TYPE3 "cxl-type3"  
> 

-- 
Fan Ni <nifan@outlook.com>
