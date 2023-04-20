Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E011C77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 15:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjDTP60 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Apr 2023 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjDTP6V (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Apr 2023 11:58:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B404EEB
        for <linux-cxl@vger.kernel.org>; Thu, 20 Apr 2023 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682006283; x=1713542283;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+JvKqbvlPb8Hbxto9UQiA05txi30nN4ST8ne/13PK1M=;
  b=ObDLBhspHcXu631AJL9wv0v+B/ppAROKqV8TvF6+32TwvDhJo42TQRYo
   FQ05JqO6RMy7oDb8/zZmk5s100JLWj2sJUhrxwzrXw+rkopL306wu6h7n
   BAGUP39qc3S+hqNIGsQpNxfsZ+Jw/0ZlduU8Th90zn3P0sdAryPHINNgA
   IXO6ki+ofJVotquDkUVgOMWxzE4s7gPJcoXZBwGLUVPin+gliIw/ktgj2
   JC6tD4je3HgOzEZYNifQOszzCfwpa5/bmAjb8fwoCDWGimeAz2nySON+M
   5dOMUR/f/UmzscJMuurqJMqXnqs/6wpG94d9p/rUzmAAGxtr6BYDD1cOG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="325379778"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="325379778"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 08:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="685380219"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="685380219"
Received: from ewmentze-mobl2.amr.corp.intel.com (HELO [10.212.11.57]) ([10.212.11.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 08:57:28 -0700
Message-ID: <8e0bcfae-45cb-b1e1-5a5f-c96534b55f80@intel.com>
Date:   Thu, 20 Apr 2023 08:57:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: Usage of tools/testing/cxl
Content-Language: en-US
To:     RAGHU H <raghuhack78@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <CAGWUp4qXXOsFgJu9E__Y9FGhK0ARteOF-mP1P19rd3_5K=mgNg@mail.gmail.com>
 <ttel3hfuygwhdi5ds6zmn27szvaf5holl66rvcbl55myaxarqg@cwgud6xhausf>
 <CAGWUp4rS8KQ2twr2f6fjcvMzFiFamOZrPw_GViopNhM-ju0zpw@mail.gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAGWUp4rS8KQ2twr2f6fjcvMzFiFamOZrPw_GViopNhM-ju0zpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/20/23 6:05 AM, RAGHU H wrote:
> Thanks Davidlohr for responding back!
> 
> I am able to use qemu to start a guest with following configuration,
> which looks more or less same thats available config in "run_qemu.sh
> --cxl  --cxl-test"

Just FYI cxl_test devices do not show up as PCIe devices. So you won't 
see them in lspci. You can use cxl CLI (ndctl package) or look in 
/sys/bus/cxl/devices/. The below parameters creates qemu emulated CXL 
devices. If you remove the --cxl, the qemu emulated devices will go away.

> 
> -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M
> \
> -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M
> \
> -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M
> \
> -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/cxltest4.raw,size=256M
> \
> -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M
> \
> -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=256M
> \
> -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=256M
> \
> -object memory-backend-file,id=cxl-lsa4,share=on,mem-path=/tmp/lsa4.raw,size=256M
> \
> -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
> -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
> -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
> 
> 
> [root@cxl-test ~]# lspci
> 00:00.0 Host bridge: Intel Corporation 82G33/G31/P35/P31 Express DRAM Controller
> 00:01.0 VGA compatible controller: Device 1234:1111 (rev 02)
> 00:02.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> 00:1f.0 ISA bridge: Intel Corporation 82801IB (ICH9) LPC Interface
> Controller (rev 02)
> 00:1f.2 SATA controller: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH)
> 6 port SATA Controller [AHCI mode] (rev 02)
> 00:1f.3 SMBus: Intel Corporation 82801I (ICH9 Family) SMBus Controller (rev 02)
> 0c:00.0 PCI bridge: Intel Corporation Device 7075
> 0c:01.0 PCI bridge: Intel Corporation Device 7075
> 0d:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> 0e:00.0 PCI bridge: Intel Corporation Device 7075
> de:00.0 PCI bridge: Intel Corporation Device 7075
> de:01.0 PCI bridge: Intel Corporation Device 7075
> df:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> e0:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> [root@cxl-test ~]#
> 
> 
> Maybe I am wrong here but I thought I could use some of the test code
> in tools/testing/cxl to understand the cxl support in kernel & qemu.
> 
> Regards
> Raghu
> 
> 
> 
> 
> On Wed, Apr 19, 2023 at 10:29 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> On Wed, 19 Apr 2023, RAGHU H wrote:
>>
>>> Hello,
>>>
>>> Please pardon my ignorance, but would like to understand how to use
>>> tools/testing/cxl to understand the current kernel implementation of
>>> cxl code base & test framework(tools/testing/cxl).
>>>
>>> I have tried "make -C tools/testing/selftests run_tests", but it's a
>>> bit of a stretch and executes all the tests which may not be related
>>> to my quest for CXL.
>>
>> Historically this sort of mock device comes from nfit, and it was originally
>> the only way to test anything afaik, before qemu came along - and now it's
>> mostly useful for simpler unit-testing approaches.
>>
>> To properly use it I suggest reading the run_qemu.sh usage for cxl_test:
>> https://github.com/pmem/run_qemu/blob/main/run_qemu.sh
>>
>> run_qemu.sh --cxl  --cxl-test
>>
>> Thanks,
>> Davidlohr
