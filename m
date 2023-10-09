Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB418E35
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2C6A6
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 08:44:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S43HP3RYxz6J7Yy;
	Mon,  9 Oct 2023 23:44:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 16:44:35 +0100
Date: Mon, 9 Oct 2023 16:44:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
	<thuth@redhat.com>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
	<imammedo@redhat.com>, <anisinha@redhat.com>, <marcel.apfelbaum@gmail.com>,
	<pbonzini@redhat.com>, <richard.henderson@linaro.org>, <eduardo@habkost.net>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231009164434.00006711@Huawei.com>
In-Reply-To: <652048e465c8d_ae7e7294e9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231004180529-mutt-send-email-mst@kernel.org>
	<169646094762.643966.16021192876985391476.stgit@djiang5-mobl3>
	<20231004230132-mutt-send-email-mst@kernel.org>
	<12874c03-7de0-474f-9378-7d3ab8572d8d@intel.com>
	<20231005122736-mutt-send-email-mst@kernel.org>
	<20231006130939.00007a69@Huawei.com>
	<652048e465c8d_ae7e7294e9@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 6 Oct 2023 10:50:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> [..]
> > > > > 
> > > > > what does "a WORD" mean is unclear - do you match what hardware does
> > > > > when you use aml_buffer? pls mention this in commit log, and
> > > > > show actual hardware dump for comparison.    
> > > > The CXL spec says WORD without much qualification. It's a 16bit value AFAICT. I'll add additional comment. Currently I do not have access to actual hardware unfortunately. I'm constructing this purely based on spec description.    
> > >   
> > 
> > WORD does seem to be clearly defined in the ACPI spec as uint16
> > and as this is describing a DSDT blob I think we can safe that
> > it means that.  Also lines up with the fixed sizes in CEDT.  
> 
> I am not sure it means that, the ACPI specification indicates that packages
> can hold "integers" and integers can be any size up to 64-bits.

I agree that intent might be more general than an AML WORD
but was being paranoid on the basis using one was definitely never
wrong ;)

> 
> > > It's not clear buffer is actually word though.
> > > 
> > > Jonathan do you have hardware access?  
> > 
> > No.  +CC linux-cxl to see if anyone else has hardware + BIOS with
> > QTG implemented...  There will be lots of implementations soon so I'd make
> > not guarantee they will all interpret this the same.
> > 
> > Aim here is Linux kernel enablement support, and unfortunately that almost
> > always means we are ahead of easy availability of hardware. If it exists
> > its probably prototypes in a lab, in which case no guarantees on the
> > BIOS tables presented...  
> 
> From a pre-production system the ASL is putting the result of SizeOf
> directly into the first element in the return package:
> 
> 	Local1 = SizeOf (CXQI)
> 	Local0 [0x00] = Local1
> 
> ...where CXQI appears to be a fixed table of QTG ids for the platform, and
> SizeOf() returns an integer type with no restriction that it be a 16-bit
> value.
> 
> So I think the specification is misleading by specifying WORD when ACPI
> "Package" objects convey "Integers" where the size of the integer can be a
> u8 to a u64.

Good, that's simpler.

> 
> > > Also, possible to get clarification from the spec committee?  
> > 
> > I'm unclear what we are clarifying.  As I read it current implementation
> > is indeed wrong and I failed to notice this earlier :(
> > 
> > Ultimately data encoding (ACPI 6.5 section 20.2..3 Data Objects Encoding)
> > should I think be
> > 
> > 0x0B 0x00 0x00
> > WordPrefix then data : note if you try a 0x0001 and feed
> > it to iasl it will squash it into a byte instead and indeed if you
> > force the binary to the above it will decode it as 0x0000 but recompile
> > that and you will be back to just
> > 0x00 (as bytes don't need a prefix..)
> > 
> > Currently it would be.
> > 0x11     0x05 0x0a 0x02 0x00 0x01
> > BufferOp 
> > 
> > Btw I built a minimal DSDT file to test this and iasl isn't happy with
> > the fact the _DSM doesn't return anything at all if ARG2 isn't 1 or 2.
> > Whilst that's imdef territory as not covered by the CXL spec, we should
> > return 'something' ;)
> > 
> > Anyhow, to do this as per the CXL spec we need an aml_word()
> > that just implements the word case from aml_int()  
> 
> If I understand correctly, aml_int() is sufficient since this is not a
> Field() where access size matters.
> 
> > Chance are that it never matters if we get an ecoding that is
> > only single byte (because the value is small) but who knows what
> > other AML parsers might do.  
> 
> I expect the reason WORD is used in the specification is because of the
> size of the QTG ID field in the CFMWS. ACPI could support returning more
> than USHRT_MAX in an Integer field in a Package, but those IDs above
> USHRT_MAX could not be represented in CFMWS.

Agreed that's probably the cause and if anyone does use an AML WORD
by forcing the prefix, it does no harm for software stacks that
assume INTEGER.

> 
> [..]
> > > but again it is not clear at all what does spec mean.
> > > an integer up to 0xfffff? a buffer as you did? just two bytes?
> > > 
> > > could be any of these.  
> > 
> > The best we have in the way of description is the multiple QTG example
> > where it's
> > Package() {2, 1} combined with it being made up of WORDs
> > 
> > whereas in general that will get squashed to a pair of bytes...
> > So I'm thinking WORDs is max size rather than only size but
> > given ambiguity we should encode them as words anyway.  
> 
> My assertion is that for the Package format the size of the integer does
> not matter because the Package.Integer type can convey up to 64-bit values.
> For being compatible with the *usage* of that max id, values that do not
> fit into 16-bits are out of spec, but nothing prevents the Package from
> using any size integer, afaics.
> 
Works for me, though we should do the leg work to get the spec tweaked
to clarify this..

Jonathan
